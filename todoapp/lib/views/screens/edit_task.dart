import 'package:flutter/material.dart';
import 'package:todoapp/views/screens/tasks_screen.dart';

import '../../controller/edit_task.dart';
import '../widgets/failure.dart';
import '../widgets/success.dart';

class EditTaskDialog extends StatelessWidget {
  EditTaskDialog(
      {super.key,
      required this.email,
      required this.id,
      required this.title,
      required this.description});

  String email, id, title, description;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    titleController.text = title;

    TextEditingController descriptionController = TextEditingController();
    descriptionController.text = description;

    return AlertDialog(
      title: const Text('Edit Task'),
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
            var result = await editTask(
                email, id, titleController.text, descriptionController.text);
            if (result['success'] == true) {
              successDialog(context, "Task Updated Successfully!",
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
