// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Style {
  final title = GoogleFonts.acme(
      color: const Color.fromARGB(216, 244, 67, 54),
      fontSize: 50,
      fontWeight: FontWeight.bold,
      letterSpacing: 5,
      shadows: [
        const Shadow(
          blurRadius: 2.0,
          color: Color.fromARGB(224, 255, 255, 255),
          offset: Offset(-5.0, 0.0),
        ),
      ]);
  final btnGenration = GoogleFonts.bebasNeue(
    color: Colors.white,
    fontSize: 16,
    letterSpacing: 2,
  );

  final textType = GoogleFonts.bebasNeue(
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 25,
      letterSpacing: 3,
      shadows: [
        const Shadow(
          blurRadius: 3.0,
          color: Color.fromARGB(255, 201, 87, 87),
          offset: Offset(-4.0, 0.0),
        ),
      ]);
}
