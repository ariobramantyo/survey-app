part of 'detail_survey_bloc.dart';

sealed class DetailSurveyEvent extends Equatable {
  const DetailSurveyEvent();

  @override
  List<Object> get props => [];
}

class GetDetailSurvey extends DetailSurveyEvent {
  final String surveyId;

  const GetDetailSurvey(this.surveyId);

  @override
  List<Object> get props => [surveyId];
}

class NextQuestionRequested extends DetailSurveyEvent {
  // final int nextPage;

  // const NextQuestionRequested(this.nextPage);

  // @override
  // List<Object> get props => [nextPage];
}

class PreviousQuestionRequested extends DetailSurveyEvent {
  // final int previousPage;

  // const PreviousQuestionRequested(this.previousPage);

  // @override
  // List<Object> get props => [previousPage];
}

class SubmitSurveyAnswer extends DetailSurveyEvent {}

class AnswerTheQuestion extends DetailSurveyEvent {
  final String questionId;
  final String answer;

  const AnswerTheQuestion(this.questionId, this.answer);

  @override
  List<Object> get props => [questionId, answer];
}
