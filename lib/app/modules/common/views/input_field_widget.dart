import 'package:flutter/material.dart';

class FrappeTextField extends StatelessWidget {
  late String text;
  final Icon fieldIcons;
  bool? obscureText;
  TextEditingController? controller;
  FrappeTextField (this.text, this.fieldIcons,{this.controller, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText??false,
        decoration: InputDecoration(
            fillColor: Colors.grey[100],
            filled: true,
            border: OutlineInputBorder(),
            icon: fieldIcons,
            labelText: text,
            labelStyle: TextStyle(
              color: Colors.blue[600],
            )
        ),
      ),
    );
  }
}
