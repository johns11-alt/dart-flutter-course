import 'package:flutter/material.dart';
import 'package:test/screens/first_screen.dart';

Future<void> showLogoutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Επιβεβαίωση Αποσύνδεσης',
        style: TextStyle(color: Colors.black),
      ),
      content: const Text(
        'Είστε σίγουροι ότι θέλετε να αποσυνδεθείτε;',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text(
            'Άκυρο',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const FirstScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          child: const Text('Αποσύνδεση'),
        ),
      ],
    ),
  );
}
