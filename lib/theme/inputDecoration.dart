import 'package:flutter/material.dart';
import 'theme.dart';

InputDecoration getInputDecoration() => const InputDecoration(
      labelText: '',
      labelStyle: TextStyle(color: Color.fromARGB(255, 167, 167, 167)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)),
      focusColor: Color(0xFF4A3F69),
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Color.fromARGB(255, 38, 7, 122))),
    );

ButtonStyle getButtonStyle() => ButtonStyle(
      backgroundColor: MaterialStateProperty.all(MyThemeData().titlePurple),
    );
