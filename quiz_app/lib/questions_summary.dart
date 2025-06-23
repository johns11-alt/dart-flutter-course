import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return Column(
      children: summaryData.map((data) {
        return Row(
          children: [
            Text(((data['question_index'] as int) + 1).toString()),
            const SizedBox(width: 10), // Optional spacing for layout
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['question'] as String),
                const SizedBox(height: 5),
                Text(data['user_answer'] as String),
                Text(data['correct_answer'] as String),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
