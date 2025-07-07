import 'package:flutter/material.dart';

class SimpleNotes extends StatelessWidget {
  final Map<String, String> note;
  final int index;
  final void Function(int) onEdit;
  final void Function(int) onDelete;

  const SimpleNotes({
    Key? key,
    required this.note,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        color: Colors.grey[850],
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
                onPressed: () => onEdit(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => onDelete(index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
