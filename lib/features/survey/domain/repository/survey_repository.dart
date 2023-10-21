import 'package:dartz/dartz.dart';
import 'package:survey_app/features/survey/domain/model/detail_survey_question.dart';
import '../../../../core/error/failure.dart';
import '../model/survey_entity.dart';

abstract class SurveyRepository {
  Future<Either<Failure, List<SurveyEntity>>> getAllSurvey();
  Future<Either<Failure, DetailSurvey>> getDetailSurvey(String surveyId);
}
