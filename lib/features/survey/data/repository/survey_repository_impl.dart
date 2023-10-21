import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_app/features/survey/domain/model/detail_survey_question.dart';
import 'dart:developer';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/util/data_mapper.dart';
import '../../domain/model/survey_entity.dart';
import '../../domain/repository/survey_repository.dart';
import '../datasource/survey_data_source.dart';

class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyDataSource _surveyDataSource;

  SurveyRepositoryImpl({SurveyDataSource? surveyDataSource})
      : _surveyDataSource =
            surveyDataSource ?? SurveyDataSourceImpl(client: http.Client());

  @override
  Future<Either<Failure, List<SurveyEntity>>> getAllSurvey() async {
    try {
      final listAllSurvey = await _surveyDataSource.getAllSurvey();
      return right(DataMapper.mapSurveyDtoToEntity(listAllSurvey));
    } on ServerException catch (e) {
      log('error repository impl on server exception');
      return left(ServerFailure(e.message));
    } catch (e) {
      log('error repository impl');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailSurvey>> getDetailSurvey(String surveyId) async {
    try {
      final detailSurvey = await _surveyDataSource.getDetailSurvey(surveyId);
      return right(
          DataMapper.mapDetailSurveyResponsetoEntity(detailSurvey.data!));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
