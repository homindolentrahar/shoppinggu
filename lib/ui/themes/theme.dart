import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorPalette {
  static const primary = Colors.amber;
  static const red = Colors.redAccent;
  static const white = Color(0xFFFAFAFA);
  static const light = Color(0xFFF3F0F3);
  static const black = Color(0xFF202530);
  static const dark = Color(0xFF404540);
}

final appTheme = ThemeData(
  primaryColor: ColorPalette.primary,
  canvasColor: ColorPalette.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: ColorPalette.white,
    centerTitle: true,
    textTheme: TextTheme(
      title: GoogleFonts.quicksand(
        color: ColorPalette.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: TextTheme(
    button: GoogleFonts.quicksand(
      color: ColorPalette.dark,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline3: GoogleFonts.quicksand(
      color: ColorPalette.black,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    headline5: GoogleFonts.quicksand(
      color: ColorPalette.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline6: GoogleFonts.quicksand(
      color: ColorPalette.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: GoogleFonts.quicksand(
      color: ColorPalette.dark,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    subtitle2: GoogleFonts.quicksand(
      color: ColorPalette.dark,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: GoogleFonts.quicksand(
      color: ColorPalette.dark,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: GoogleFonts.quicksand(
      color: ColorPalette.dark,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
);
