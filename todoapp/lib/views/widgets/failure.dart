import 'package:flutter/material.dart';

Future failureDialog(BuildContext context, String? text, Widget targetWidget) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => targetWidget));
      });
      return AlertDialog(
        backgroundColor: Colors.red,
        content: Text(
          text!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    },
  );
}
