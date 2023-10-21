import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/color.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/presentation/wrapper/bloc/auth_bloc.dart';
import 'features/auth/presentation/wrapper/wrapper.dart';
import 'features/survey/data/repository/survey_repository_impl.dart';
import 'features/survey/domain/repository/survey_repository.dart';

void main() {
  runApp(App(
    authRepository: AuthRepositoryImpl(),
    surveyRepository: SurveyRepositoryImpl(),
  ));
}

class App extends StatelessWidget {
  final AuthRepository authRepository;
  final SurveyRepository surveyRepository;

  const App({
    super.key,
    required this.authRepository,
    required this.surveyRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: surveyRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authenticationRepository: authRepository),
          )
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Wrapper(),
    );
  }
}
