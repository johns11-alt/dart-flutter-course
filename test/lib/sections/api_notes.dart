import 'package:flutter/material.dart';

class ApiNotes extends StatelessWidget {
  final Map<String, String> note;
  final int index;
  final void Function(int) onDelete;

  const ApiNotes({
    Key? key,
    required this.note,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        color: Colors.grey[850],
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
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => onDelete(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
