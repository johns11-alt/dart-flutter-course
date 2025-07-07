import 'package:flutter/material.dart';
import 'package:test/screens/first_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final List<String> notes = ['job 1', 'job 2', 'job 3'];
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose(); // Always dispose controllers
    super.dispose();
  }

  void _addNote() {
    final newNote = _noteController.text.trim();
    if (newNote.isNotEmpty) {
      setState(() {
        notes.add(newNote);
        _noteController.clear();
      });
    }
  }

  void _getData() async {
    final apiText = await Uri.parse('https://catfact.ninja/fact');
    final apiImage = await Uri.parse('https://dog.ceo/api/breeds/image/random');
    print(apiText);
    print(apiImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar Title'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Προσθήκη σημείωσης:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your note',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: _addNote,
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 224, 119, 38),
                  child: TextButton(
                    onPressed: _getData,
                    child: const Text(
                      'api',
                      style: TextStyle(
                        color: Colors
                            .white, // To make text visible on colored background
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('your jobs:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Expanded(
              child: notes.isEmpty
                  ? const Center(child: Text('No notes yet!'))
                  : ListView(
                      children: notes
                          .map(
                            (note) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Card(
                                child: ListTile(
                                  title: Text(note),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        notes.remove(note);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
