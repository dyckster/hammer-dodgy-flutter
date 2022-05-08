import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  Styles._();

  static TextStyle movieTitleTextStyle = GoogleFonts.montserrat(
      fontWeight: FontWeight.w900,
      fontSize: 64,
      textStyle: const TextStyle(color: Colors.white));

  static TextStyle movieDescriptionTextStyle = GoogleFonts.roboto(
      textStyle: const TextStyle(color: Color(0xD9FFFFFF), fontSize: 14));

  static TextStyle movieLinksTextStyle = GoogleFonts.roboto(
      fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white);

  static TextStyle movieLinksTextStyleUnderline = GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white,
      textStyle: const TextStyle(decoration: TextDecoration.underline));
}
