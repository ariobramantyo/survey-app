import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/features/auth/domain/repository/auth_repository.dart';
import '../../../../core/theme/typo.dart';
import '../../domain/repository/survey_repository.dart';
import 'bloc/home_bloc.dart';

import '../component/survey_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          surveyRepository: RepositoryProvider.of<SurveyRepository>(context))
        ..add(GetAllSurvey()),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text('Halaman Survei'),
            actions: [
              IconButton(
                  onPressed: () {
                    RepositoryProvider.of<AuthRepository>(context).logout();
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is Success) {
                return ListView.builder(
                  itemCount: state.survey.length,
                  itemBuilder: (context, index) {
                    final survey = state.survey[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 5),
                      child: SurveyCard(
                        title: survey.surveyName,
                        description: survey.createdAt,
                        surveyId: survey.id,
                      ),
                    );
                  },
                );
              } else if (state is Empty) {
                return const Center(
                  child: Text(
                    'Survey tidak tersedia',
                    style: AppTypography.regular,
                  ),
                );
              } else if (state is Error) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: AppTypography.regular,
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
