import 'package:flutter/material.dart';

class customFormTextField extends StatelessWidget {
  customFormTextField({this.hintText, this.onchanged, required this.hidden});

  final Function(String)? onchanged;
  final String? hintText;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidden,
      validator: (data) {
        if (data!.isEmpty) return "field is required";
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
