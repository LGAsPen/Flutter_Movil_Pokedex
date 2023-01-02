// ignore_for_file: file_names
import 'package:flutter/material.dart';

/*
 * * Clase para crear borde tipo s
 * * @borderedondo recibe valores de 0 a 1
 */
class MyCustomClipperForAppbar extends CustomClipper<Path> {
  final double borderedondo;
  MyCustomClipperForAppbar({required this.borderedondo});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0,
        (size.height - size.width * borderedondo) - size.width * borderedondo);
    path.quadraticBezierTo(0, (size.height - size.width * borderedondo),
        size.width * 0.1, (size.height - size.width * borderedondo));
    path.lineTo(size.width - size.width * borderedondo,
        (size.height - size.width * borderedondo));
    path.quadraticBezierTo(size.width,
        (size.height - size.width * borderedondo), size.width, size.height);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
