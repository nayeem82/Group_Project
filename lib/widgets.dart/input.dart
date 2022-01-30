import 'package:ecommerce/constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String hintText;

  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final bool isPasswordField;
  final TextInputAction textInputAction;

  Input(
      {this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
          border: Border.all(
        color: Color(0xFFF2F2F2),
      )),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "HintText",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            )),
        style: Constants.regularDarkText,
      ),
    );
  }
}
