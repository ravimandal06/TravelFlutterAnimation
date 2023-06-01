import 'package:flutter/material.dart';

import '../styles.dart';

class CurvePainter extends CustomPainter {
  CurvePainter(this.animationValue);
  final double animationValue;
  double? width;

  double interpolate(double x) {
    return width! / 2 + (x - width! / 2) * animationValue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    width = size.width;
    paint.color = white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    var path = Path();

//    print(interpolate(size, x))
    var startPoint = Offset(interpolate(width! / 2 + 20), 4);
    var controlPoint1 = Offset(interpolate(width! / 2 + 60), size.height / 4);
    var controlPoint2 = Offset(interpolate(width! / 2 + 20), size.height / 4);
    var endPoint = Offset(interpolate(width! / 2 + 55 + 4), size.height / 3);

    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    startPoint = endPoint;
    controlPoint1 = Offset(interpolate(width! / 2 + 100), size.height / 2);
    controlPoint2 = Offset(interpolate(width! / 2 + 20), size.height / 2 + 40);
    endPoint =
        Offset(interpolate(width! / 2 + 50 + 2), 2 * size.height / 3 - 1);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    startPoint = endPoint;
    controlPoint1 =
        Offset(interpolate(width! / 2 - 20), 2 * size.height / 3 - 10);
    controlPoint2 =
        Offset(interpolate(width! / 2 + 20), 5 * size.height / 6 - 10);
    endPoint = Offset(interpolate(width! / 2), 5 * size.height / 6 + 2);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    startPoint = endPoint;
    controlPoint1 = Offset(interpolate(width! / 2 - 100), size.height - 80);
    controlPoint2 = Offset(interpolate(width! / 2 - 40), size.height - 50);
    endPoint = Offset(interpolate(width! / 2 - 50), size.height - 4);

    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
