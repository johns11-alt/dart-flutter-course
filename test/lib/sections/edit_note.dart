import 'package:flutter/material.dart';

Future<void> showEditNoteDialog({
  required BuildContext context,
  required String initialText,
  required Function(String) onSave,
}) {
  final editController = TextEditingController(text: initialText);

  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Επεξεργασία', style: TextStyle(color: Colors.black)),
      content: TextField(
        controller: editController,
        autofocus: true,
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          hintText: 'Επεξεργασία της σημείωσης',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        style: const TextStyle(color: Colors.black),
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
            final updatedText = editController.text.trim();
            if (updatedText.isNotEmpty) {
              onSave(updatedText);
            }
            Navigator.of(ctx).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          child: const Text('Οκ'),
        ),
      ],
    ),
  );
}
