import 'package:flutter/material.dart';

class NoteInput extends StatelessWidget {
  final TextEditingController noteController;
  final VoidCallback onAddNote;
  final VoidCallback onGetData;

  const NoteInput({
    Key? key,
    required this.noteController,
    required this.onAddNote,
    required this.onGetData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: const Text(
            'Προσθήκη σημείωσης:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.green,
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: onAddNote,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onGetData,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: const Color.fromARGB(255, 224, 119, 38),
                ),
                child: const Text(
                  'api',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
