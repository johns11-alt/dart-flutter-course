import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(context) {
    const gap = SizedBox(height: 30);

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You answered X out of Y answers correctly!'),
            gap,
            const Text('List of answers and questions'),
            gap,
            TextButton(onPressed: () {}, child: Text("Restart Quiz!")),
          ],
        ),
      ),
    );
  }
}
