import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, bool>> editTask(
    String email, String id, String title, String description) async {
  var url = Uri.parse('http://127.0.0.1:8000/edit_task/');

  var response = await http.post(
    url,
    body: jsonEncode(
        {'id': id, 'email': email, "title": title, "description": description}),
  );
  if (response.statusCode == 200) {
    return {"success": true};
  } else {
    return {"success": false};
  }
}
