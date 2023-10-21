import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/model/survey_entity.dart';
import '../../../domain/repository/survey_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SurveyRepository _surveyRepository;

  HomeBloc({
    required SurveyRepository surveyRepository,
  })  : _surveyRepository = surveyRepository,
        super(HomeInitial()) {
    on<GetAllSurvey>((event, emit) async {
      emit(Loading());

      final surveysEither = await _surveyRepository.getAllSurvey();

      surveysEither.fold(
        (failure) {
          emit(Error(message: failure.message));
        },
        (survey) {
          if (survey.isEmpty) {
            emit(Empty());
          } else {
            emit(Success(survey: survey));
          }
        },
      );
    });
  }
}
