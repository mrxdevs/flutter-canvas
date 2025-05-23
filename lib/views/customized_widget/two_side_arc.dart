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
    final centerX = w / 2;
    final centerY = h / 2;

    final center = Offset(centerX, h * 1.5); // Your existing center

    // Example: Draw a red arc
    final Paint arcPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke // Or PaintingStyle.fill
      ..strokeWidth = 5.0;

    // Define the bounding rectangle for the arc
    // For example, an arc centered in the widget, with a radius of 50
    final Rect arcRect =
        Rect.fromCircle(center: Offset(centerX, centerY), radius: centerY);

    // Define start and sweep angles (in radians)
    // 0 radians is 3 o'clock. pi radians is 180 degrees.
    const double startAngle = 0; // Start at 3 o'clock
    const double sweepAngle = -180; // Draw a semicircle (180 degrees)

    // Draw the arc
    canvas.drawArc(
        arcRect, startAngle, angleToRadians(sweepAngle), false, arcPaint);

    // You can add more drawing logic here for your tyre pressure gauge
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
