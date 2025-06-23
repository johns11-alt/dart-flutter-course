import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(context) {
    const gap = SizedBox(height: 30);
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    // print(numTotalQuestions);
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      // child: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You answered $numCorrectQuestions out of $numTotalQuestions answers correctly!'),
            gap,
            QuestionsSummary(getSummaryData()),
            gap,
            TextButton(onPressed: () {}, child: Text("Restart Quiz!")),
          ],
        ),
        // ),
      ),
    );
  }
}
