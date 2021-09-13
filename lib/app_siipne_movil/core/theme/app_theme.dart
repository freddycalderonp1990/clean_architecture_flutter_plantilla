import 'package:flutter/material.dart' show Colors, TextTheme, ThemeData;
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black));
}
