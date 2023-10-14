import 'package:flutter/material.dart';
import 'package:todoapp/controller/all_tasks.dart';
import 'package:todoapp/views/screens/login.dart';
import '../../controller/complete_task.dart';
import '../../controller/delete_task.dart';
import '../../models/task.dart';
import '../widgets/failure.dart';
import '../widgets/success.dart';
import 'edit_task.dart';
import 'new_task.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({super.key, required this.email});

  String email;

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    List<Task> temp = await fetchTasks(widget.email);
    setState(() {
      tasks = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: null,
          body: Column(
            children: [
              Container(
                  color: const Color(0xFF457CE0),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: const [
                        Text(
                          'Your Todo',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Unleash your productivity and achieve your goals effortlessly by efficiently managing your tasks',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: task.isDone == "1"
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(
                        "${task.description}\n",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditTaskDialog(
                                    email: widget.email,
                                    id: task.id,
                                    title: task.title,
                                    description: task.description,
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () async {
                              var result =
                                  await completeTask(task.id, widget.email);
                              if (result['success'] == true) {
                                successDialog(
                                    context,
                                    "Task Completed Successfully!",
                                    TasksScreen(email: widget.email));
                              } else {
                                failureDialog(context, "Something went wrong",
                                    TasksScreen(email: widget.email));
                              }
                            },
                            icon: const Icon(Icons.check),
                          ),
                          IconButton(
                            onPressed: () async {
                              var result =
                                  await deleteTask(task.id, widget.email);
                              if (result['success'] == true) {
                                successDialog(
                                    context,
                                    "Task Deleted Successfully!",
                                    TasksScreen(email: widget.email));
                              } else {
                                failureDialog(context, "Something went wrong",
                                    TasksScreen(email: widget.email));
                              }
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // Buttons at the bottom
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Icon(Icons.logout),
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewTaskDialog(email: widget.email);
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
