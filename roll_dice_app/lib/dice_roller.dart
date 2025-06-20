import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  // var activeDiceImage = 'assets/images/dice-2.png';
  final randomizer = Random();

  var currentDiceRoll = 2;

  void rollDice() {
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
      print("changing...");
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/dice-$currentDiceRoll.png', width: 200),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: EdgeInsets.only(top: 20),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text('Roll Dice now!'),
        ),
      ],
    );
  }
}
