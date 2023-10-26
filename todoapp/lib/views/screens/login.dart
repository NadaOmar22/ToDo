import 'package:flutter/material.dart';
import 'package:todoapp/views/screens/register.dart';
import 'package:todoapp/views/screens/tasks_screen.dart';
import 'package:todoapp/views/widgets/failure.dart';
import 'package:todoapp/views/widgets/success.dart';

import '../../controller/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: const Color(0xFF457CE0),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'welcome.jpg',
                width: 100.0,
                height: 100.0,
              ),
              const SizedBox(
                height: 100.0,
              ),
              TextFormField(
                cursorColor:
                    const Color(0xFF457CE0), // Change the cursor color here
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a userName' : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0xFF457CE0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0xFF457CE0)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                cursorColor:
                    const Color(0xFF457CE0), // Change the cursor color here
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a password' : null,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0xFF457CE0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0xFF457CE0)),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () async {
                  var result = await login(email, password);
                  if (result['success'] == true) {
                    successDialog(
                        context,
                        "You logged in successfully!",
                        TasksScreen(
                          email: email,
                        ));
                  } else {
                    failureDialog(
                        context, "Something went wrong", const LoginScreen());
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  primary:
                      const Color(0xFF457CE0), // Set the button color to teal
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(
                        color: Color(0xFF457CE0)), // Set the border color
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  primary: Colors.white, // Set the button color to teal
                ),
                child: const Text(
                  'Create new account',
                  style: TextStyle(
                    color: Color(0xFF457CE0),
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
