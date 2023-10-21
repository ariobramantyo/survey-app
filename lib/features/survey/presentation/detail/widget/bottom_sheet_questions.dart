import 'package:flutter/material.dart';
import '../../../../../core/theme/color.dart';
import '../../../../../core/theme/typo.dart';

class BottomSheetQuestions extends StatefulWidget {
  final List<int> questionNumbers;
  final int itemsPerPage;

  const BottomSheetQuestions({
    super.key,
    required this.questionNumbers,
    required this.itemsPerPage,
  });

  @override
  _BottomSheetQuestionsState createState() => _BottomSheetQuestionsState();
}

class _BottomSheetQuestionsState extends State<BottomSheetQuestions> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.7,
      color: Colors.white,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Survey Question',
              style: AppTypography.title.copyWith(fontSize: 18),
            ),
          ),
          const Divider(),
          const SizedBox(height: 5),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount:
                  (widget.questionNumbers.length / widget.itemsPerPage).ceil(),
              itemBuilder: (context, pageIndex) {
                final startIndex = pageIndex * widget.itemsPerPage;
                final endIndex = (pageIndex + 1) * widget.itemsPerPage;
                final pageQuestions = widget.questionNumbers.sublist(
                  startIndex,
                  endIndex > widget.questionNumbers.length
                      ? widget.questionNumbers.length
                      : endIndex,
                );

                return Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  spacing: 20,
                  children: pageQuestions.map((questionNumber) {
                    return Container(
                      height: 61,
                      width: 61,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColor.secondaryText),
                          color: Colors.white),
                      child: Center(child: Text('$questionNumber')),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                (widget.questionNumbers.length / widget.itemsPerPage).ceil(),
                (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentPage ? Colors.blue : Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
