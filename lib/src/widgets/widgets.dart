import 'package:flutter/material.dart';

class Widgets {
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
