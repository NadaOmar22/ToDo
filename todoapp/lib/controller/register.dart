import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, bool>> register(
    String username, String email, String password) async {
  var url = Uri.parse('http://127.0.0.1:8000/register/');

  var response = await http.post(
    url,
    body: jsonEncode({'name': username, 'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    return {"success": true};
  } else {
    return {"success": false};
  }
}
