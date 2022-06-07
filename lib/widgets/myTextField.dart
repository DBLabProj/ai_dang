import 'package:flutter/material.dart';

class MyTextField {
  Widget _widget = const TextField();
  final TextEditingController _controller = TextEditingController();
  final Color _red = const Color(0xffCF2525);
  final Color _gray = const Color(0xffD6D6D6);
  final Color _darKGray = const Color(0xff3E3E3E);
  Widget _fieldLabel = const Text('');

  MyTextField(type, icons, label, hint) {
    TextInputType inputType = TextInputType.text;
    bool obscureText = false;

    if (type == 'email') {
      inputType = TextInputType.emailAddress;
    } else if (type == 'password') {
      obscureText = true;
    }
    _widget = TextField(
      controller: _controller,
      cursorColor: _red,
      keyboardType: inputType,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      onEditingComplete: () {

      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: _darKGray),
        prefixIcon: Icon(icons, color: _darKGray),

            focusColor: _red,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: _gray),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: _red),
            ),
          ),
        );
  }

  Widget getWidget() {
    return _widget;
  }

  String getText() {
    return _controller.text;
  }

}
