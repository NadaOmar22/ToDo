import 'package:flutter/material.dart';
import 'package:todoapp/views/screens/login.dart';

import '../../controller/register.dart';
import '../widgets/failure.dart';
import '../widgets/success.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String userName;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                cursorColor: const Color(0xFF457CE0),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
                onChanged: (value) {
                  setState(() {
                    email = value.trim();
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
                cursorColor: const Color(0xFF457CE0),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter  your username' : null,
                onChanged: (value) {
                  setState(() {
                    userName = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Username',
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
                cursorColor: const Color(0xFF457CE0),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password' : null,
                onChanged: (value) {
                  setState(() {
                    password = value.trim();
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
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () async {
                  var result = await register(userName, email, password);
                  if (result['success'] == true) {
                    successDialog(context, "Your account created successfully!",
                        const LoginScreen());
                  } else {
                    failureDialog(context, "Something went wrong",
                        const RegisterScreen());
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
                  'Register',
                  style: TextStyle(
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
