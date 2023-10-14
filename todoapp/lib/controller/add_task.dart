import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, bool>> addTask(
    String email, String title, String description) async {
  var url = Uri.parse('http://127.0.0.1:8000/create_task/');

  var response = await http.post(
    url,
    body: jsonEncode({
      'title': title,
      'description': description,
      'email': email,
    }),
  );
  if (response.statusCode == 200) {
    return {"success": true};
  } else {
    return {"success": false};
  }
}
