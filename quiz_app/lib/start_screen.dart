import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';

class StartScreen extends StatelessWidget {
   final void Function() switchScreen;
  const StartScreen(this.switchScreen, {super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: 0.3,
          //   child: Image.asset('assets/images/quiz-logo.png', width: 200)),
          // SizedBox(height: 50,),
          // const Text('Learn Flutter the fun way!', style: TextStyle(
          //   color: Color.fromARGB(255, 255, 255, 255),
          //   fontSize: 22
          // )),
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 200,
            color: Color.fromARGB(90, 255, 255, 255),
          ),
          SizedBox(height: 50),
          const Text(
            'Learn Flutter the fun way!',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 22,
            ),
          ),
          SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: () {
              switchScreen();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              side: BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
            ),
            icon: Icon(Icons.arrow_right_alt),
            label: Text('Start Quiz!!!'),
          ),
        ],
      ),
    );
  }
}
