import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:survey_app/features/survey/data/dto/detail_survey_response.dart';

import '../../../../core/error/exception.dart';
import '../dto/list_all_survey_response.dart';

abstract class SurveyDataSource {
  Future<ListAllSurveyResponse> getAllSurvey();
  Future<DetailSurveyResponse> getDetailSurvey(String surveyId);
}

const String baseUrl = 'https://panel-demo.obsight.com/api';

class SurveyDataSourceImpl extends SurveyDataSource {
  final http.Client client;

  SurveyDataSourceImpl({required this.client});

  @override
  Future<ListAllSurveyResponse> getAllSurvey() async {
    final uri = Uri.parse('$baseUrl/survey');

    const secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'TOKEN');

    final response = await http.get(uri,
        headers: {"Content-Type": "text/json", "Cookie": 'token=$token'});

    final bodyResponse =
        ListAllSurveyResponse.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      throw ServerException(bodyResponse.message ?? 'Terjadi kesalahan');
    }

    return bodyResponse;
  }

  @override
  Future<DetailSurveyResponse> getDetailSurvey(String surveyId) async {
    final uri = Uri.parse('$baseUrl/survey/$surveyId');

    const secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'TOKEN');

    final response = await http.get(
      uri,
      headers: {"Content-Type": "text/json", "Cookie": 'token=$token'},
    );

    final bodyResponse = jsonDecode(response.body);

    if (bodyResponse['code'] != 200) {
      throw ServerException(bodyResponse.message ?? 'Terjadi kesalahan');
    }

    final result = DetailSurveyResponse.fromJson(bodyResponse);
    return result;
  }
}
