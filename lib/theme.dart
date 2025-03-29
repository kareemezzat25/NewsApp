import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static const Color lightColor = Color(0xFFFFFFFF);
  static const Color darkColor = Color(0xFF171717);
  static const Color textColor = Color(0xFFA0A0A0);
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: lightColor,
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: darkColor)),
      textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
              fontSize: 24, fontWeight: FontWeight.w500, color: darkColor),
          titleMedium: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.w500, color: darkColor),
          titleSmall: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w700, color: darkColor),
          bodyLarge: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w500, color: lightColor),
          bodyMedium: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w500, color: textColor)));
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: darkColor,
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: lightColor)),
      textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
              fontSize: 24, fontWeight: FontWeight.w500, color: lightColor),
          titleMedium: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.w500, color: lightColor),
          titleSmall: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w700, color: lightColor),
          bodyLarge: GoogleFonts.inter(
              fontSize: 14, fontWeight: FontWeight.w500, color: darkColor),
          bodyMedium: GoogleFonts.inter(
              fontSize: 12, fontWeight: FontWeight.w500, color: textColor)));
}
