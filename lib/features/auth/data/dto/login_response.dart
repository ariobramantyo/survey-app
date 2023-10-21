import 'user_dto.dart';

class LoginResponse {
  final bool status;
  final String message;
  final UserDTO? data;

  LoginResponse({required this.status, required this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json['status'],
        message: json['message'],
        data: json['status'] ? UserDTO.fromJson(json['data']) : null,
      );
}
