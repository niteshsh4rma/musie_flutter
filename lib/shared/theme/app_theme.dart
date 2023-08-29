import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light = FlexColorScheme.light(
    scheme: FlexScheme.redWine,
    textTheme: GoogleFonts.interTextTheme(),
  ).toTheme;

  static ThemeData dark = FlexColorScheme.dark(
    scheme: FlexScheme.redWine,
    textTheme: GoogleFonts.interTextTheme(),
  ).toTheme;
}
