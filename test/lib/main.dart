import 'package:flutter/material.dart';
import 'package:test/screens/first_screen.dart';



void main() {
  // runApp(const ProviderScope(child: App()));
  runApp(const App());
  
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: theme,
      home: const FirstScreen(),
    );
  }
}
