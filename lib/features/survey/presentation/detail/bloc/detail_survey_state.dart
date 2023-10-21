part of 'detail_survey_bloc.dart';

enum GetDetailStatus { initial, loading, success, failed }

class DetailSurveyState extends Equatable {
  final GetDetailStatus getSurveyStatus;
  final int currentPage;
  final DetailSurvey? survey;
  final Map<String, dynamic> answer;
  final String surveyErrorMessage;

  DetailSurveyState({
    this.getSurveyStatus = GetDetailStatus.initial,
    this.currentPage = 0,
    this.survey,
    Map<String, dynamic>? answer,
    this.surveyErrorMessage = '',
  }) : answer = answer ?? {};

  DetailSurveyState copyWith({
    GetDetailStatus? getSurveyStatus,
    int? currentPage,
    DetailSurvey? survey,
    Map<String, dynamic>? answer,
    String? surveyErrorMessage,
  }) {
    return DetailSurveyState(
      getSurveyStatus: getSurveyStatus ?? this.getSurveyStatus,
      survey: survey ?? this.survey,
      currentPage: currentPage ?? this.currentPage,
      answer: answer ?? this.answer,
      surveyErrorMessage: surveyErrorMessage ?? this.surveyErrorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [getSurveyStatus, currentPage, survey, answer, surveyErrorMessage];
}
