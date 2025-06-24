import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

void main() {
    runApp(MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      theme: ThemeData().copyWith(
        // scaffoldBackgroundColor: Color.fromARGB(255, 220, 189, 252),
        // elevatedButtonTheme: ElevatedButtonThemeData(),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        )
        ),
      home: Expenses(),
    )
  );
}
