import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, bool>> deleteTask(String id, String email) async {
  var url = Uri.parse('http://127.0.0.1:8000/delete_task/');

  var response = await http.post(
    url,
    body: jsonEncode({
      'id': id,
      'email': email,
    }),
  );
  if (response.statusCode == 200) {
    return {"success": true};
  } else {
    return {"success": false};
  }
}
