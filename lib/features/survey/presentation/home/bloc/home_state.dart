part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class Empty extends HomeState {}

final class Loading extends HomeState {}

final class Success extends HomeState {
  final List<SurveyEntity> survey;

  const Success({required this.survey});

  @override
  List<Object> get props => [survey];
}

final class Error extends HomeState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
