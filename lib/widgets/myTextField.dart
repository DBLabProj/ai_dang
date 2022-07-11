import 'package:flutter/material.dart';

class MyTextField {
  Widget _widget = const TextField();
  final TextEditingController _controller = TextEditingController();

  final Color _red = const Color(0xffCF2525);
  final Color _gray = const Color(0xffD6D6D6);
  final Color _darKGray = const Color(0xff3E3E3E);

  TextInputType _inputType = TextInputType.text;
  bool _obscureText = false;
  String _label = '';
  String _hint = '';
  var _icons;

  MyTextField(type, icons, label, hint) {

    if (type == 'email') {
      _inputType = TextInputType.emailAddress;
    } else if (type == 'password') {
      _obscureText = true;
    }
    _label = label;
    _hint = hint;
    _icons = icons;

    _widget = TextField(
      controller: _controller,
      cursorColor: _red,
      keyboardType: _inputType,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      onSubmitted: (value) {},
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        labelStyle: TextStyle(color: _darKGray),
        prefixIcon: Icon(_icons, color: _darKGray),

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

  void setOnSubmitted(Function(void string) func) {
    _widget = TextField(
      controller: _controller,
      cursorColor: _red,
      keyboardType: _inputType,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      onSubmitted: func,
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        labelStyle: TextStyle(color: _darKGray),
        prefixIcon: Icon(_icons, color: _darKGray),

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

}
