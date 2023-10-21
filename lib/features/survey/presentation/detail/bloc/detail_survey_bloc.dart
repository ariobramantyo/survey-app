import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/detail_survey_question.dart';
import '../../../domain/repository/survey_repository.dart';

part 'detail_survey_event.dart';
part 'detail_survey_state.dart';

class DetailSurveyBloc extends Bloc<DetailSurveyEvent, DetailSurveyState> {
  final SurveyRepository _surveyRepository;

  DetailSurveyBloc({required SurveyRepository surveyRepository})
      : _surveyRepository = surveyRepository,
        super(DetailSurveyState()) {
    on<GetDetailSurvey>((event, emit) async {
      emit(state.copyWith(getSurveyStatus: GetDetailStatus.loading));

      final detailSurveyEither =
          await _surveyRepository.getDetailSurvey(event.surveyId);

      detailSurveyEither.fold(
        (failure) {
          emit(state.copyWith(
              getSurveyStatus: GetDetailStatus.failed,
              surveyErrorMessage: failure.message));
        },
        (detailSurvey) {
          emit(
            state.copyWith(
                getSurveyStatus: GetDetailStatus.success,
                survey: detailSurvey,
                answer: _generateAnswerTemplate(detailSurvey)),
          );
        },
      );
    });

    on<NextQuestionRequested>((event, emit) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    });

    on<PreviousQuestionRequested>((event, emit) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    });

    on<SubmitSurveyAnswer>((event, emit) {
      debugPrint(jsonEncode(state.answer));
    });

    on<AnswerTheQuestion>((event, emit) {
      var answerMap = state.answer;

      for (var answer in answerMap['answers']) {
        if (answer['question_id'] == event.questionId) {
          answer['answer'] = event.answer;
          emit(state.copyWith(answer: answerMap));
          break;
        }
      }
    });
  }

  Map<String, dynamic> _generateAnswerTemplate(DetailSurvey survey) {
    Map<String, dynamic> answer = {
      "survey_id": survey.id,
    };

    List<Map<String, dynamic>> answers = [];
    for (var question in survey.questions!) {
      answers.add({'question_id': question.id, 'answer': ''});
    }

    answer['answers'] = answers;
    return answer;
  }
}
