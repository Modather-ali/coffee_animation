import 'package:flutter/material.dart';

class RectCanvas extends CustomPainter {
  final Color color;
  final String text;
  RectCanvas(this.color, this.text);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect =
        Rect.fromCenter(center: const Offset(0, 0), width: 120, height: 50);
    RRect rRect = RRect.fromRectAndCorners(
      rect,
      topRight: const Radius.circular(20),
      topLeft: const Radius.circular(20),
      bottomLeft: const Radius.circular(20),
      bottomRight: const Radius.circular(20),
    );
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rRect, paint);
  }
}
