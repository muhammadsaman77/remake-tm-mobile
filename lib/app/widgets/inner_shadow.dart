import 'dart:ui';

import 'package:flutter/material.dart';

class InnerShadowContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double opacity;

  InnerShadowContainer({
    required this.width,
    required this.height,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: InnerShadowPainter(
          color: color,
          opacity: opacity,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              'Inner Shadow',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final Color color;
  final double opacity;

  InnerShadowPainter({
    required this.color,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
        Radius.circular(12.0),
      ));

    canvas.drawShadow(path, Colors.black, 0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
