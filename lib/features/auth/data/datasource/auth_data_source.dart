import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../dto/login_response.dart';
import '../dto/user_dto.dart';

const String baseUrl = 'https://panel-demo.obsight.com/api';

abstract class AuthDataSource {
  Future<LoginResponse> login(String email, String password);
  Future<void> logout();
  Future<UserDTO> getUserCredential();
  Future<void> setUserCredential(UserDTO user);
}

class AuthDataSourceImpl extends AuthDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;

  AuthDataSourceImpl({required this.client, required this.secureStorage});

  @override
  Future<UserDTO> getUserCredential() async {
    final user = await secureStorage.read(key: 'USER');

    if (user == null) {
      throw LocalException('User credential tidak ditemukan');
    }
    return UserDTO.fromJson(jsonDecode(user));
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    final loginResponse =
        await client.post(url, body: {'email': email, 'password': password});

    final bodyResponse = LoginResponse.fromJson(jsonDecode(loginResponse.body));

    var headersList = loginResponse.headers['set-cookie']!.split(";");
    late String token;
    for (var kvPair in headersList) {
      var kv = kvPair.split("=");
      var key = kv[0];
      var value = kv[1];

      if (key.contains("token")) {
        token = value;
        break;
      }
    }
    await secureStorage.write(key: 'TOKEN', value: token);

    if (loginResponse.statusCode != 200) {
      throw ServerException(bodyResponse.message);
    }

    bodyResponse.data!.email = email;
    return bodyResponse;
  }

  @override
  Future<void> setUserCredential(UserDTO user) async {
    final Map<String, dynamic> userMap = user.toJson();
    await secureStorage.write(key: 'USER', value: jsonEncode(userMap));
  }

  @override
  Future<void> logout() async {
    await secureStorage.delete(key: 'USER');
    await secureStorage.delete(key: 'TOKEN');
  }
}
