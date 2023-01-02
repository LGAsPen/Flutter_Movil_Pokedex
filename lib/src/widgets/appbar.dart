import 'package:flutter/material.dart';

class PersonalizedAppBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double borderedondo = 0.08;
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final d = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path();
    final a = Path();

    path.lineTo(0,
        (size.height - size.width * borderedondo) - size.width * borderedondo);
    path.quadraticBezierTo(0, (size.height - size.width * borderedondo),
        size.width * 0.1, (size.height - size.width * borderedondo));
    path.lineTo(size.width - size.width * borderedondo,
        (size.height - size.width * borderedondo));
    path.quadraticBezierTo(size.width,
        (size.height - size.width * borderedondo), size.width, size.height);
    path.lineTo(size.width, 0);

    a
      ..moveTo(0, size.height - size.height * 0.5)
      ..lineTo(0, 0);
    a
      ..moveTo(0, size.height - size.height * 0.5)
      ..quadraticBezierTo(0, (size.height - size.width * borderedondo),
          size.width * 0.1, (size.height - size.width * borderedondo));
    // a
    //   ..moveTo(0, size.height - size.height * 0.5)
    //   ..lineTo(size.width - 30, (size.height - size.width * borderedondo));
    a
      ..moveTo(size.width * 0.1, size.height - size.height * 0.31)
      ..quadraticBezierTo(
        size.width * 0.3,
        (size.height - size.width * borderedondo),
        size.width - 20,
        size.height - size.height * 0.2,
      );
    a
      ..moveTo(size.width, size.height - 30)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
    canvas.drawPath(a, d);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// void paint(Canvas canvas, Size size) {
//   double w = size.width;
//   double h = size.height;
//   double r = 15; //<-- corner radius

//   Paint blackPaint = Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 5;

//   Paint redPaint = Paint()
//     ..color = Colors.red
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 5;

//   RRect fullRect = RRect.fromRectAndRadius(
//     Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
//     Radius.circular(r),
//   );

//   Path topRightArc = Path()
//     ..moveTo(w - r, 0)
//     ..arcToPoint(Offset(w, r), radius: Radius.circular(r));

//   Path bottomLeftArc = Path()
//     ..moveTo(r, h)
//     ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r));

//   canvas.drawRRect(fullRect, blackPaint);
//   canvas.drawPath(topRightArc, redPaint);
//   canvas.drawPath(bottomLeftArc, redPaint);
// }
