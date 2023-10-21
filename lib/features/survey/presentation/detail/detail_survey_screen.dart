import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/survey_repository.dart';
import 'bloc/detail_survey_bloc.dart';
import 'widget/survey_body.dart';
import '../../../../core/theme/typo.dart';

class DetailSurveyScreen extends StatefulWidget {
  const DetailSurveyScreen({super.key, required this.surveyId});

  final String surveyId;

  @override
  State<DetailSurveyScreen> createState() => _DetailSurveyScreenState();
}

class _DetailSurveyScreenState extends State<DetailSurveyScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailSurveyBloc(
          surveyRepository: RepositoryProvider.of<SurveyRepository>(context))
        ..add(GetDetailSurvey(widget.surveyId)),
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<DetailSurveyBloc, DetailSurveyState>(
          builder: (context, state) {
            if (state.getSurveyStatus == GetDetailStatus.failed) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    state.surveyErrorMessage,
                    textAlign: TextAlign.center,
                    style: AppTypography.regular,
                  ),
                ),
              );
            } else if (state.getSurveyStatus == GetDetailStatus.success) {
              return const SurveyBody();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )),
      ),
    );
  }
}
