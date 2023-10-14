import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> completeTask(String id, String email) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/complete_task/'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'id': int.parse(id), // Convert id to integer
      'email': email,
    }),
  );
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as String;
    return {
      "success": true,
      "message": jsonData,
    };
  } else {
    final jsonData = json.decode(response.body) as String;
    return {
      "success": false,
      "message": jsonData,
    };
  }
}
