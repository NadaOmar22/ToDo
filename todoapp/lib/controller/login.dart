import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, bool>> login(String email, String password) async {
  var url = Uri.parse('http://127.0.0.1:8000/login/');

  var response = await http.post(
    url,
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    return {"success": true};
  } else {
    return {"success": false};
  }
}
