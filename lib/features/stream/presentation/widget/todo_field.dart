import 'package:flutter/material.dart';
import 'package:practice_stream/features/stream/domain/entities/todo_entities.dart';

class TodoField extends StatefulWidget {
  const TodoField({super.key, required this.onSubmitted, this.todoData});

  final Function(TodoEntities) onSubmitted;
  final TodoEntities? todoData;

  @override
  State<TodoField> createState() => _TodoFieldState();
}

class _TodoFieldState extends State<TodoField> {
  final TextEditingController _titleController = TextEditingController();
  bool _isCompleted = false;
  int _id = DateTime.now().millisecondsSinceEpoch;
  String _submitText = "Submit";

  @override
  void initState() {
    super.initState();
    if (widget.todoData != null) {
      _titleController.text = widget.todoData!.title;
      _isCompleted = widget.todoData!.completed;
      _id = widget.todoData!.id;
      _submitText = "Update";
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Completed"),
                const SizedBox(width: 10),
                Switch(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                if (title.isNotEmpty) {
                  final todo = TodoEntities(
                    id: _id,
                    title: title,
                    completed: _isCompleted,
                  );
                  widget.onSubmitted(todo);
                }
              },
              child: Text(_submitText),
            ),
          ],
        ),
      ),
    );
  }
}
