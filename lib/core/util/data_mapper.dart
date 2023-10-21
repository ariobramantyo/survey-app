import '../../features/survey/data/dto/detail_survey_response.dart';
import '../../features/survey/domain/model/detail_survey_question.dart'
    as detail_survey;

import '../../features/auth/data/dto/login_response.dart';
import '../../features/auth/data/dto/user_dto.dart';
import '../../features/auth/domain/model/user_entity.dart';
import '../../features/survey/data/dto/list_all_survey_response.dart';
import '../../features/survey/domain/model/survey_entity.dart';

class DataMapper {
  static UserEntity mapLoginResponseToEntity(LoginResponse input) {
    return UserEntity(
        email: input.data!.email ?? '',
        occupationLevel: input.data!.occupationLevel ?? 0,
        occupationName: input.data!.occupationName ?? '');
  }

  static UserEntity mapUserDtoToEntity(UserDTO input) {
    return UserEntity(
        email: input.email ?? '',
        occupationLevel: input.occupationLevel ?? 0,
        occupationName: input.occupationName ?? '');
  }

  static UserDTO mapEntityToDto(UserEntity input) {
    return UserDTO(
      email: input.email,
      occupationLevel: input.occupationLevel,
      occupationName: input.occupationName,
    );
  }

  static List<SurveyEntity> mapSurveyDtoToEntity(ListAllSurveyResponse input) {
    if (input.data == null) {
      return List<SurveyEntity>.empty();
    }

    final surveyEntity = input.data!.map((survey) {
      return SurveyEntity(
        id: survey.id ?? '',
        surveyName: survey.surveyName ?? '',
        status: survey.status ?? 0,
        totalRespondent: survey.totalRespondent ?? 0,
        createdAt: survey.createdAt ?? '',
        updatedAt: survey.updatedAt ?? '',
        questions: mapQuestionDtoToEntity(survey.questions),
      );
    }).toList();

    return surveyEntity;
  }

  static List<QuestionsEntity> mapQuestionDtoToEntity(List<Questions>? input) {
    if (input == null) {
      return List<QuestionsEntity>.empty();
    }

    final questionEntity = input.map((question) {
      return QuestionsEntity(
          questionName: question.questionName ?? '',
          inputType: question.inputType ?? '',
          questionId: question.questionId ?? '');
    }).toList();

    return questionEntity;
  }

  static detail_survey.DetailSurvey mapDetailSurveyResponsetoEntity(
      DataQuestionResponse input) {
    return detail_survey.DetailSurvey(
      id: input.id,
      surveyName: input.surveyName,
      status: input.status,
      totalRespondent: input.totalRespondent,
      createdAt: input.createdAt,
      updatedAt: input.updatedAt,
      questions: mapQuestionSurveyResponseToEntity(input.questions),
    );
  }

  static List<detail_survey.Questions> mapQuestionSurveyResponseToEntity(
      List<QuestionResponse>? input) {
    if (input == null) {
      return List<detail_survey.Questions>.empty();
    }

    final questions = input.map((question) {
      return detail_survey.Questions(
        id: question.id,
        questionNumber: question.questionNumber,
        surveyId: question.surveyId,
        section: question.section,
        inputType: question.inputType,
        questionName: question.questionName,
        questionSubject: question.questionSubject,
        options: mapOptionSurveyResponseToEntity(question.options),
      );
    }).toList();

    return questions;
  }

  static List<detail_survey.Options> mapOptionSurveyResponseToEntity(
      List<OptionResponse>? input) {
    if (input == null) {
      return List<detail_survey.Options>.empty();
    }

    final options = input.map((option) {
      return detail_survey.Options(
          id: option.id,
          questionId: option.questionId,
          optionName: option.optionName,
          value: option.value,
          color: option.color);
    }).toList();

    return options;
  }
}
