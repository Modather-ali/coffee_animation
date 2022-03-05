import 'package:flutter/material.dart';

class MyCanvas extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect =
        Rect.fromCenter(center: const Offset(0, 50), width: 200, height: 200);
    Paint paint = Paint()
      ..color = Colors.brown.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawOval(rect, paint);
  }
}
