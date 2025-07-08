import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  final List<Map<String, String>> _notes = [];

  List<Map<String, String>> get notes => List.unmodifiable(_notes);

  void addNote(Map<String, String> note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void removeNoteAt(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }

  void editNoteAt(int index, String updatedText) {
    if (_notes[index]['type'] == 'text') {
      _notes[index]['note'] = updatedText;
      notifyListeners();
    }
  }
}