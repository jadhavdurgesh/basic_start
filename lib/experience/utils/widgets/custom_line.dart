import 'package:basic_start/constants/colors.dart';
import 'package:flutter/material.dart';

class SnakeLineHalfColorPainter extends CustomPainter {

  final int divider;

  SnakeLineHalfColorPainter({super.repaint, required this.divider});


  @override
  void paint(Canvas canvas, Size size) {
    // Create the path for the snake-like curve
    Path path = Path();
    path.moveTo(0, size.height / 2); // Start at the middle-left

    double step = size.width / 30; // Divide width into 20 equal segments

    // Draw the snake-like curve
    for (int i = 0; i < 30; i++) {
      double x1 = (i + 0.5) * step;
      double x2 = (i + 1) * step;
      double controlPointY =
          (i % 2 == 0) ? size.height * 0.4 : size.height * 0.6;

      path.quadraticBezierTo(x1, controlPointY, x2, size.height / 2);
    }

    // Set up paint for half the curve (black on the left half)
    Paint blackPaint = Paint()
      ..color = primaryAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Set up paint for the other half (yellow on the right half)
    Paint yellowPaint = Paint()
      ..color = surfaceWhite1
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Clip and draw the left half (black)
    canvas.save();
    canvas.clipRect(
        Rect.fromLTWH(0, 0, size.width / divider, size.height)); // Clip to left half
    canvas.drawPath(path, blackPaint);
    canvas.restore();

    // Clip and draw the right half (yellow)
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(
        size.width / divider, 0, size.width , size.height)); // Clip to right half
    canvas.drawPath(path, yellowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
