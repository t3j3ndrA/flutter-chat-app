import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  final titlePurple = Color(0xFF4A3F69);
  final placeHolderColor = Color.fromARGB(255, 167, 167, 167);

  ThemeData getTheme() => ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
            bodyText1: GoogleFonts.lato(
                fontSize: 18, color: Color.fromARGB(255, 24, 24, 24)),
            button: GoogleFonts.lato(fontSize: 18, color: Colors.white),
            bodyText2: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0))),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: titlePurple, size: 32),
          actionsIconTheme: IconThemeData(color: titlePurple, size: 32),
          titleTextStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: titlePurple,
              letterSpacing: 1.8),
        ),
      );
}

SizedBox getTopPadding() => SizedBox(
      height: 16,
    );
