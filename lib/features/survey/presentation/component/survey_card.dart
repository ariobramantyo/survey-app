import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/color.dart';
import '../../../../core/theme/typo.dart';
import '../detail/detail_survey_screen.dart';

class SurveyCard extends StatelessWidget {
  const SurveyCard(
      {super.key,
      required this.title,
      required this.description,
      required this.surveyId});

  final String title;
  final String description;
  final String surveyId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailSurveyScreen(surveyId: surveyId),
            ));
      },
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xffD9D9D9))),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/survey_label.svg',
              width: 54,
              height: 54,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTypography.regular
                        .copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Text(description,
                    style: AppTypography.regular12.copyWith(
                        fontWeight: FontWeight.w500, color: AppColor.green)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
