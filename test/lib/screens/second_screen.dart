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
        notes.insert(0, {
          'type': 'api',
          'fact': factText,
          'image': imageLink,
        });
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
      title: const Text('Edit Note'),
      content: TextField(
        controller: editController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Update your note',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text('Cancel'),
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
          child: const Text('Save'),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const FirstScreen(),
                ),
              );
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
              Center(
                child: const Text(
                  'Προσθήκη σημείωσης:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // const Text('your jobs:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Expanded(
  child: notes.isEmpty
      ? const Center(child: Text('No notes yet!'))
      : Container(
          color: Colors.black, // background behind list items
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (ctx, index) {
              final note = notes[index];

              if (note['type'] == 'api') {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Card(
                    color: Colors.grey[850], // dark grey background like in screenshot
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          note['image']!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            note['fact']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => _removeNote(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Card(
                    color: Colors.grey[850], // dark grey background
                    child: ListTile(
                      title: Text(
                        note['note']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () => _editNote(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => _removeNote(index),
                          ),
                        ],
                      ),
                    ),
                  ),
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
