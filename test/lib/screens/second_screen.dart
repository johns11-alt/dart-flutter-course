import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test/screens/first_screen.dart';
import 'package:http/http.dart' as http;

import 'package:test/sections/simple_notes.dart';
import 'package:test/sections/api_notes.dart';
import 'package:test/sections/note_input.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // Change from List<String> to List<Map<String, String>>
  final List<Map<String, String>> notes = [];
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addNote() {
    final newNote = _noteController.text.trim();
    if (newNote.isNotEmpty) {
      setState(() {
        notes.insert(0, {'type': 'text', 'note': newNote});
        _noteController.clear();
      });
    }
  }

  void _getData() async {
    final factUrl = Uri.parse('https://catfact.ninja/fact');
    final imageUrl = Uri.parse('https://dog.ceo/api/breeds/image/random');

    try {
      final factResponse = await http.get(factUrl);
      final factData = json.decode(factResponse.body);
      final factText = factData['fact'];

      final imageResponse = await http.get(imageUrl);
      final imageData = json.decode(imageResponse.body);
      final imageLink = imageData['message'];

      setState(() {
        notes.insert(0, {'type': 'api', 'fact': factText, 'image': imageLink});
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _removeNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _editNote(int index) {
    final oldNote = notes[index]['note']!;
    final editController = TextEditingController(text: oldNote);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Επεξεργασία', style: TextStyle(color: Colors.black)),
        content: TextField(
          controller: editController,
          autofocus: true,
          cursorColor: Colors.black, // Cursor color black
          decoration: const InputDecoration(
            hintText: 'Επεξεργασία της σημείωσης',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ), // underline when not focused
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ), // underline when focused
            ),
          ),
          style: const TextStyle(color: Colors.black), // input text color black
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Άκυρο',
              style: TextStyle(color: Colors.black), // button text black
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedText = editController.text.trim();
              if (updatedText.isNotEmpty) {
                setState(() {
                  notes[index]['note'] = updatedText;
                });
              }
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // button background black
              foregroundColor: Colors.white, // button text white
            ),
            child: const Text('Οκ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => const FirstScreen()));
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteInput(
                noteController: _noteController,
                onAddNote: _addNote,
                onGetData: _getData,
              ),

              Expanded(
                child: notes.isEmpty
                    ? Container(
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                            'No notes yet!',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.black, // background behind list items
                        child: ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (ctx, index) {
                            final note = notes[index];

                            if (note['type'] == 'api') {
                              return ApiNotes(
                                note: note,
                                index: index,
                                onDelete: _removeNote,
                              );
                            } else {
                              return SimpleNotes(
                                note: note,
                                index: index,
                                onEdit: _editNote,
                                onDelete: _removeNote,
                              );
                            }
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
