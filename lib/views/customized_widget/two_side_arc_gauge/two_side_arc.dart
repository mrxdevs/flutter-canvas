import 'dart:math';

import 'package:flutter/material.dart';

import 'two_side_arc_gauge_screen.dart';

class TyrePressureAnimationWidget2 extends StatefulWidget {
  final double rearTyrePressure;
  final double frontTyrePressure;
  final ArrowSide? arrowSide;
  final Color? bgColor;
  final Color? sideBgColor;
  const TyrePressureAnimationWidget2(
      {super.key,
      required this.rearTyrePressure,
      required this.frontTyrePressure,
      this.arrowSide = ArrowSide.None,
      this.bgColor,
      this.sideBgColor});

  @override
  State<TyrePressureAnimationWidget2> createState() =>
      _TyrePressureAnimationWidgetState();
}

class _TyrePressureAnimationWidgetState
    extends State<TyrePressureAnimationWidget2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 32).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant TyrePressureAnimationWidget2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rearTyrePressure != widget.rearTyrePressure ||
        oldWidget.frontTyrePressure != widget.frontTyrePressure) {
      _controller.reset();
      _animation = Tween<double>(begin: 0, end: 32).animate(_controller);
      _controller.forward();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: TyerMeterPainter(
                percentage: _animation.value,
                rightTyrePressure:
                    widget.rearTyrePressure > 32 ? 32 : widget.rearTyrePressure,
                leftTyrePressure: widget.frontTyrePressure > 29
                    ? 29
                    : widget.frontTyrePressure,
                bgColor: widget.bgColor ?? Colors.grey,
                sideBgColor: widget.sideBgColor ?? Colors.white,
                arrowSide: widget.arrowSide,
                leftProgressColor: (widget.frontTyrePressure < 24 ||
                        widget.frontTyrePressure > 29)
                    ? Colors.red
                    : Colors.green, //for front tyre
                rightProgressColor: (widget.rearTyrePressure < 27 ||
                        widget.rearTyrePressure > 32)
                    ? Colors.red
                    : Colors.green, //for rear tyre
                progressArrowColor: Colors.white,
                arrowSize: 5,
                gapSize: 2),
          );
        });
  }
}

class TyerMeterPainter extends CustomPainter {
  final ArrowSide? arrowSide;
  final double percentage;
  final double leftTyrePressure;
  final double rightTyrePressure;
  final Color? bgColor;
  final Color? leftProgressColor;
  final Color? rightProgressColor;
  final Color? progressArrowColor;
  final Color? gradiant1;
  final Color? gradiant2;
  final double? barWidth;
  final double? gradiantWidth;
  final double? arrowSize;
  final double? gapSize;

  final Color? sideBgColor;

  TyerMeterPainter(
      {this.arrowSide = ArrowSide.None,
      this.sideBgColor,
      super.repaint,
      required this.leftTyrePressure,
      required this.rightTyrePressure,
      required this.percentage,
      this.bgColor,
      this.leftProgressColor,
      this.rightProgressColor,
      this.progressArrowColor,
      this.gradiant1,
      this.gradiant2,
      this.barWidth,
      this.gradiantWidth,
      this.gapSize,
      this.arrowSize});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final double arcRadius = w * 2;
    const arcStrokeWidth = 10.0;
    const triangleGap = 20.0; // Distance from arc
    const triangleSize = 24.0; // Side length of triangle
    final center = Offset(w / 2, arcRadius);

    // paint for all five arcs
    final Paint arcPaint = Paint()
      ..color = Colors.red.withAlpha(100)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = arcStrokeWidth;

    final Paint arcLeftBgPaint = arcPaint;
    arcLeftBgPaint.color = Colors.white;
    final Paint arcLeftPaint = arcPaint;
    arcLeftPaint.color = Colors.red;
    final Paint arcRightBgPaint = arcPaint;
    arcRightBgPaint.color = Colors.white;
    final Paint arcRightPaint = arcPaint..color = Colors.green;

    final Rect arcRect = Rect.fromCircle(center: center, radius: arcRadius);
    const double startAngle = 180 + 80;
    const double sweepAngle = 20;
    // Update this line:
    final triangleAngle = startAngle + (percentage / 32 * sweepAngle);
    canvas.drawArc(arcRect, angleToRadians(startAngle),
        angleToRadians(sweepAngle), false, arcPaint);

    // Draw triangle outside arc, rotating with angle
    drawRotatingTriangle(
      canvas: canvas,
      center: center,
      arcRadius: arcRadius,
      arcStrokeWidth: arcStrokeWidth,
      triangleGap: triangleGap,
      triangleSize: triangleSize,
      angle: triangleAngle,
    );
  }

  void drawRotatingTriangle({
    required Canvas canvas,
    required Offset center,
    required double arcRadius,
    required double arcStrokeWidth,
    required double triangleGap,
    required double triangleSize,
    required double angle,
  }) {
    final Paint trianglePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // Calculate the point on the arc where the triangle should be placed
    final double rad = angleToRadians(angle);
    final double triangleDistance =
        arcRadius + arcStrokeWidth / 2 + triangleGap + triangleSize / 2;
    final Offset triangleCenter = Offset(
      center.dx + triangleDistance * cos(rad),
      center.dy + triangleDistance * sin(rad),
    );

    // Triangle points (equilateral, pointing outward)
    final double baseAngle = rad + pi / 2;
    final double halfBase = triangleSize / 2;
    final double height = triangleSize * sqrt(3) / 2;
    final Offset p1 = Offset(
      triangleCenter.dx - height * cos(rad),
      triangleCenter.dy - height * sin(rad),
    );
    final Offset p2 = Offset(
      triangleCenter.dx + halfBase * cos(baseAngle),
      triangleCenter.dy + halfBase * sin(baseAngle),
    );
    final Offset p3 = Offset(
      triangleCenter.dx - halfBase * cos(baseAngle),
      triangleCenter.dy - halfBase * sin(baseAngle),
    );

    final Path trianglePath = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..close();

    canvas.drawPath(trianglePath, trianglePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double radiansToDegrees(double radians) {
    return radians * (180 / pi);
  }

  Offset angleToOffset(Offset center, double angle, double distance) {
    final radian = angleToRadians(angle);
    return Offset(
      center.dx + distance * cos(radian),
      center.dy + distance * sin(radian),
    );
  }

  double angleToRadians(double angle) {
    return angle * (pi / 180);
  }
}
