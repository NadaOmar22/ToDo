import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task.dart';

Future<List<Task>> fetchTasks(String email) async {
  List<Task> tasks = [];
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/all_tasks/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      tasks = jsonData.map<Task>((item) {
        return Task(
          title: item['title'],
          description: item['description'],
          id: item['id'].toString(),
          isDone: item['iscomplete'].toString(),
        );
      }).toList();
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return tasks;
}
