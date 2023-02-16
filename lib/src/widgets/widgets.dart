import 'package:flutter/material.dart';

class Widgets {
  final decorationCard = BoxDecoration(
    gradient: LinearGradient(
      colors: <Color>[
        const Color.fromARGB(188, 118, 155, 172).withOpacity(0.2),
        const Color.fromARGB(255, 0, 170, 255).withOpacity(0.9),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  bottomNavigationBarItem(String label, String urlImage) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        "assets/icons/$urlImage",
        height: 30.0,
      ),
      label: label,
    );
  }
}
