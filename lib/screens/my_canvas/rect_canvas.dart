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

    drawRRect(canvas, rect);
    drawText(canvas, rect.width);
  }

  void drawRRect(Canvas canvas, Rect rect) {
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

  void drawText(
    Canvas canvas,
    double maxWidth,
  ) {
    final TextSpan textSpan = TextSpan(
      text: text,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 20,
        color: text == "Log In"
            ? const Color(0xFFfbf8cc)
            : const Color(0xFF9c6644),
      ),
    );
    final TextPainter textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    textPainter.paint(canvas, const Offset(-30, -12));
  }
}
