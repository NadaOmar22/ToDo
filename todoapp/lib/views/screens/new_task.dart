import 'package:flutter/material.dart';
import 'package:todoapp/controller/add_task.dart';
import 'package:todoapp/views/screens/tasks_screen.dart';

import '../widgets/failure.dart';
import '../widgets/success.dart';

class NewTaskDialog extends StatelessWidget {
  NewTaskDialog({super.key, required this.email});

  String email;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return AlertDialog(
      title: const Text('New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            var result = await addTask(
                email, titleController.text, descriptionController.text);
            if (result['success'] == true) {
              successDialog(context, "Task Added Successfully!",
                  TasksScreen(email: email));
            } else {
              failureDialog(
                  context, "Something went wrong", TasksScreen(email: email));
            }
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
