import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/notes_provider.dart';
import 'package:test/sections/simple_notes.dart';
import 'package:test/sections/api_notes.dart';
import 'package:test/sections/note_input.dart';
import 'package:test/sections/edit_note.dart';
import 'package:test/sections/logout_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addNote() {
    final newNote = _noteController.text.trim();
    if (newNote.isNotEmpty) {
      Provider.of<NotesProvider>(
        context,
        listen: false,
      ).addNote({'type': 'text', 'note': newNote});
      _noteController.clear();
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

      Provider.of<NotesProvider>(
        context,
        listen: false,
      ).addNote({'type': 'api', 'fact': factText, 'image': imageLink});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _removeNote(int index) {
    Provider.of<NotesProvider>(context, listen: false).removeNoteAt(index);
  }

  void _editNote(int index) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    final oldNote = notesProvider.notes[index]['note']!;
    showEditNoteDialog(
      context: context,
      initialText: oldNote,
      onSave: (updatedText) {
        notesProvider.editNoteAt(index, updatedText);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context).notes;

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
              showLogoutDialog(context);
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
                        color: const Color.fromARGB(255, 51, 46, 46),
                        child: const Center(
                          child: Text(
                            'No notes yet!',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      )
                    : Container(
                        color: const Color.fromARGB(255, 51, 46, 46),
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
              Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  '©2020 Ime Informatics',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}