import 'package:flutter/material.dart';
import 'package:roll_dice_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color.fromARGB(255, 43, 139, 119),
          Color.fromARGB(255, 155, 59, 59),
        ),
      ),
    ),
  );
}
