import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/color.dart';
import '../../../../core/theme/typo.dart';
import '../../domain/model/detail_survey_question.dart';
import '../detail/bloc/detail_survey_bloc.dart';

class QuestionContent extends StatelessWidget {
  const QuestionContent({super.key, required this.question});

  final Questions question;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Survey Nasional',
                style: AppTypography.subHeading
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                '${question.questionNumber ?? 0}. ${question.questionName ?? ''}',
                style: AppTypography.subHeading
                    .copyWith(color: AppColor.secondaryText),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(
              thickness: 13,
              color: Color(0xffEEF6F9),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('Answer',
                  style: AppTypography.regular.copyWith(fontSize: 15)),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<DetailSurveyBloc, DetailSurveyState>(
                builder: (context, state) {
                  var answerMap = state.answer;
                  var savedAnswer = '';
                  for (var answer in answerMap['answers']) {
                    if (answer['question_id'] == question.id) {
                      savedAnswer = answer['answer'];
                      break;
                    }
                  }
                  if (question.inputType == 'type text' ||
                      question.inputType == 'text') {
                    return TextFieldAnser(
                        savedAnswer: savedAnswer, questionId: question.id!);
                  }
                  if (question.inputType == 'radio_button') {
                    return RadioButtonOptions(
                      options: question.options ?? [],
                      questionId: question.id!,
                      savedAnswer: savedAnswer,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldAnser extends StatefulWidget {
  const TextFieldAnser(
      {super.key, required this.savedAnswer, required this.questionId});

  final String savedAnswer;
  final String questionId;

  @override
  State<TextFieldAnser> createState() => _TextFieldAnserState();
}

class _TextFieldAnserState extends State<TextFieldAnser> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.savedAnswer);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      style: AppTypography.regular12,
      decoration: InputDecoration(
          hintStyle: AppTypography.regular12.copyWith(color: Colors.grey),
          hintText: 'Isi jawaban Anda'),
      onChanged: (value) {
        context
            .read<DetailSurveyBloc>()
            .add(AnswerTheQuestion(widget.questionId, value));
      },
    );
  }
}

class RadioButtonOptions extends StatefulWidget {
  const RadioButtonOptions(
      {super.key,
      required this.options,
      required this.questionId,
      required this.savedAnswer});

  final List<Options> options;
  final String questionId;
  final String savedAnswer;

  @override
  State<RadioButtonOptions> createState() => _RadioButtonOptionsState();
}

class _RadioButtonOptionsState extends State<RadioButtonOptions> {
  late List<String> options;
  late String? selectedOption;

  @override
  void initState() {
    super.initState();
    options = widget.options.map((option) => option.optionName ?? '').toList();
    selectedOption =
        options.contains(widget.savedAnswer) ? widget.savedAnswer : '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...options.map((option) => ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(option),
              leading: Radio(
                value: option,
                groupValue: selectedOption,
                activeColor: AppColor.primary,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    context
                        .read<DetailSurveyBloc>()
                        .add(AnswerTheQuestion(widget.questionId, value!));
                  });
                },
              ),
            ))
      ],
    );
  }
}
