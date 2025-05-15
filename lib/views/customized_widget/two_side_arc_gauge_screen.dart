import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_canvas/constants/app_colors.dart';

enum ArrowSide { LEFT, RIGHT, NONE }

class TyrePressureAnimationWidget extends StatefulWidget {
  final double rearTyrePressure;
  final double frontTyrePressure;
  final ArrowSide? arrowSide;
  final Color? bgColor;
  final Color? sideBgColor;
  const TyrePressureAnimationWidget(
      {super.key,
      required this.rearTyrePressure,
      required this.frontTyrePressure,
      this.arrowSide = ArrowSide.NONE,
      this.bgColor,
      this.sideBgColor});

  @override
  State<TyrePressureAnimationWidget> createState() =>
      _TyrePressureAnimationWidgetState();
}

class _TyrePressureAnimationWidgetState
    extends State<TyrePressureAnimationWidget>
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
  void didUpdateWidget(covariant TyrePressureAnimationWidget oldWidget) {
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
                    ? AppColors.darkAppBar
                    : AppColors.lightPrimary, //for front tyre
                rightProgressColor: (widget.rearTyrePressure < 27 ||
                        widget.rearTyrePressure > 32)
                    ? AppColors.darkAppBar
                    : AppColors.lightPrimary, //for rear tyre
                progressArrowColor: AppColors.lightOnPrimary,
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
      {this.arrowSide = ArrowSide.NONE,
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
    final center = Offset(centerX, h * 1.5);

    final largeRect = Rect.fromCenter(
        center: Offset(centerX, h * 1.5), width: w * 3, height: h * 2.8);

    final thickPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final startAngle = angleToRadians(255);
    final sweepAngle = angleToRadians(285 - 255);
    angleToRadians((285 - 255) * percentage / 100);

    // Draw the gradient arc as gradiant color
    // canvas.drawArc(gradientRect, startAngle, pointedSweepAngle, false, paint);

//Background arc
    canvas.drawArc(
      largeRect,
      startAngle,
      sweepAngle,
      false,
      thickPaint..color = bgColor ?? Colors.grey,
    );

    final double gap = gapSize ?? 6;
    final double gapWidth = gap / 2;

    //LeftBack ground arc
    final leftBackStartAngle = startAngle;
    final leftBackSweepAngle = angleToRadians(270 - 255 - gapWidth);
    canvas.drawArc(
      largeRect,
      leftBackStartAngle,
      leftBackSweepAngle,
      false,
      thickPaint..color = sideBgColor ?? Colors.white,
    );

    // RightBack ground arc

    final rightBackStartAngle = angleToRadians(270 + gapWidth);
    final rightBackSweepAngle = angleToRadians(285 - 270 - gapWidth);
    canvas.drawArc(
      largeRect,
      rightBackStartAngle,
      rightBackSweepAngle,
      false,
      thickPaint..color = sideBgColor ?? Colors.white,
    );

    double leftValue = leftTyrePressure;
    if (percentage <= leftTyrePressure) {
      leftValue = percentage;
    }
    final double leftValuePercentage = leftValue * 100 / 29; //for front tyre

    canvas.drawArc(
      largeRect,
      leftBackStartAngle,
      leftBackSweepAngle / 100 * leftValuePercentage,
      false,
      thickPaint..color = leftProgressColor ?? AppColors.darkPrimary,
    );

    double rightValue = rightTyrePressure;
    if (percentage <= rightTyrePressure) {
      rightValue = percentage;
    }
    final double rightValuePercentage = rightValue * 100 / 32; //for rear tyre

    canvas.drawArc(
      largeRect,
      angleToRadians(285),
      angleToRadians(270 - 285 + gapWidth) / 100 * rightValuePercentage,
      false,
      thickPaint..color = rightProgressColor ?? AppColors.lightPrimary,
    );
    Offset progressEndPoint = const Offset(0, 0);

    if (arrowSide == ArrowSide.LEFT) {
      progressEndPoint = angleToOffset(
        center,
        255 + (leftValuePercentage / 100) * (270 - gap / 2 - 255),
        w * 1.5 - 20,
      );
    }
    if (arrowSide == ArrowSide.RIGHT) {
      progressEndPoint = angleToOffset(
        center,
        radiansToDegrees(rightBackStartAngle) +
            (rightValuePercentage / 100) *
                radiansToDegrees(rightBackSweepAngle), // Changed to addition
        w * 1.5 - 20,
      );
    }

    final directionVector = progressEndPoint - center;

    final magnitude = directionVector.distance;

    final normalizedDirection =
        Offset(directionVector.dx / magnitude, directionVector.dy / magnitude);

    final perpVector1 = Offset(-normalizedDirection.dy, normalizedDirection.dx);
    final perpVector2 = Offset(normalizedDirection.dy, -normalizedDirection.dx);

    final sideLength = arrowSize ?? 5.0;

    final trianglePoint1 = progressEndPoint +
        normalizedDirection * sideLength +
        perpVector1 * sideLength;
    final trianglePoint2 = progressEndPoint +
        normalizedDirection * sideLength +
        perpVector2 * sideLength;

    final path = Path()
      ..moveTo(trianglePoint1.dx, trianglePoint1.dy)
      ..lineTo(progressEndPoint.dx, progressEndPoint.dy)
      ..lineTo(trianglePoint2.dx, trianglePoint2.dy)
      ..close(); // Close the path to form a triangle

// Draw the triangle
    if (arrowSide != ArrowSide.NONE) {
      canvas.drawPath(path, Paint()..color = progressArrowColor ?? Colors.grey);
    }
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
