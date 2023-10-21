import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/color.dart';
import '../../../../../core/theme/typo.dart';
import '../../component/question_content.dart';
import '../bloc/detail_survey_bloc.dart';
import 'bottom_sheet_questions.dart';

class SurveyBody extends StatefulWidget {
  const SurveyBody({super.key});

  @override
  State<SurveyBody> createState() => _SurveyBodyState();
}

class _SurveyBodyState extends State<SurveyBody> {
  late final PageController _pageController;
  List<Widget> questionsBox = [];

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
  Widget build(BuildContext buildContext) {
    return Column(
      children: [
        _buildHeader(buildContext),
        _buildContent(),
        Container(
          width: double.infinity,
          height: 74,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: BlocBuilder<DetailSurveyBloc, DetailSurveyState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: state.currentPage != 0
                            ? () {
                                context
                                    .read<DetailSurveyBloc>()
                                    .add(PreviousQuestionRequested());
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutQuart,
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side:
                                    const BorderSide(color: AppColor.primary))),
                        child: Text(
                          'Back',
                          style: AppTypography.buttons
                              .copyWith(color: AppColor.primary),
                        ));
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: BlocBuilder<DetailSurveyBloc, DetailSurveyState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (state.currentPage != questionsBox.length - 1) {
                            context
                                .read<DetailSurveyBloc>()
                                .add(NextQuestionRequested());
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutQuart,
                            );
                          } else {
                            Widget cancelButton = TextButton(
                              child: const Text("Batal"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            Widget continueButton = TextButton(
                              child: const Text("Submit"),
                              onPressed: () {
                                context
                                    .read<DetailSurveyBloc>()
                                    .add(SubmitSurveyAnswer());
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: const Text("Submit Survey"),
                              content: const Text(
                                  "Apakah Anda yakin ingin menyelesaikan survey ini? Pastikan Anda telah menjawab semua pertanyaan"),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: BlocBuilder<DetailSurveyBloc, DetailSurveyState>(
                          buildWhen: (previous, current) =>
                              previous.currentPage != current.currentPage,
                          builder: (context, state) {
                            return Text(
                              state.currentPage != questionsBox.length - 1
                                  ? 'Next'
                                  : 'Submit',
                              style: AppTypography.buttons
                                  .copyWith(color: Colors.white),
                            );
                          },
                        ));
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeader(BuildContext buildContext) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColor.primary)),
            child: Text(
              '45 Second Left',
              style: AppTypography.regular.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColor.primary),
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: buildContext,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return BottomSheetQuestions(
                    questionNumbers: List.generate(
                        questionsBox.length, (index) => index + 1),
                    itemsPerPage: 20,
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  const Icon(
                    Icons.list_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  BlocBuilder<DetailSurveyBloc, DetailSurveyState>(
                    buildWhen: (previous, current) =>
                        previous.currentPage != current.currentPage,
                    builder: (context, state) {
                      return Text(
                        '${state.currentPage + 1}/${state.survey!.questions!.length}',
                        style: AppTypography.regular.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<DetailSurveyBloc, DetailSurveyState>(
      buildWhen: (previous, current) => previous.survey != current.survey,
      builder: (context, state) {
        questionsBox = state.survey!.questions!
            .map((question) => QuestionContent(question: question))
            .toList();

        return Expanded(
          child: SizedBox(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questionsBox.length,
              itemBuilder: (context, index) {
                return questionsBox[index];
              },
            ),
          ),
        );
      },
    );
  }
}
