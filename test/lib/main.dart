import 'package:flutter/material.dart';
import 'package:test/screens/first_screen.dart';
import 'package:provider/provider.dart';
import 'package:test/notes_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => NotesProvider(), child: const App()),
  );
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