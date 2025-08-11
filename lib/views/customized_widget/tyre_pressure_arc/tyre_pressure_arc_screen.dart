// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class TyrePressureArcController {
  // This will hold a reference to the private state's replay function.
  VoidCallback? _replayAnimation;

  /// Triggers the replay animation on the associated ChargeLeftArc widget.
  void replay() {
    _replayAnimation?.call();
  }
}

class TyrePressureArc extends StatefulWidget {
  final double value;

  final Color? bgColor;
  final Color? frColor;
  final Color? triangleColor;
  final PaintingStyle? arcBgStyle;
  final StrokeCap? arcBgStroke;
  final double? arcBgWidth;
  final PaintingStyle? arcFrStyle;
  final StrokeCap? arcFrStroke;
  final double? arcFrWidth;
  final double? triangleSize;
  final double? triangleGap;
  final TyrePressureArcController? controller;
  const TyrePressureArc(
      {super.key,
      required this.value,
      this.bgColor,
      this.frColor,
      this.triangleColor,
      this.arcBgStyle,
      this.arcBgStroke,
      this.arcBgWidth,
      this.arcFrStyle,
      this.arcFrStroke,
      this.arcFrWidth,
      this.triangleSize,
      this.triangleGap,
      this.controller});

  @override
  State<TyrePressureArc> createState() =>
      _TyrePressureArcAnimationWidgetState();
}

class _TyrePressureArcAnimationWidgetState extends State<TyrePressureArc>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    widget.controller?._replayAnimation = _replay;
    _animationController.forward();
  }

  void repeatAnimation() {
    _animationController.repeat();
  }

  @override
  void didUpdateWidget(covariant TyrePressureArc oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      widget.controller?._replayAnimation = _replay;
    }
    if (oldWidget.value != widget.value) {
      _animationController.reset();
      _animation =
          Tween<double>(begin: 0, end: 1).animate(_animationController);
      _animationController.forward();
      _replay();
    }
  }

  void _replay() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: ChargeLeftArcPainter(
                percentage: _animation.value,
                value: widget.value,
                bgColor: widget.bgColor,
                frColor: widget.frColor,
                triangleColor: widget.triangleColor,
                triangleGap: widget.triangleGap,
                triangleSize: widget.triangleSize,
                arcBgStroke: widget.arcBgStroke,
                arcBgStyle: widget.arcBgStyle,
                arcBgWidth: widget.arcBgWidth,
                arcFrStroke: widget.arcFrStroke,
                arcFrStyle: widget.arcFrStyle,
                arcFrWidth: widget.arcFrWidth),
          );
        });
  }
}

class ChargeLeftArcPainter extends CustomPainter {
  final double percentage;
  final double value;

  final Color? bgColor;
  final Color? frColor;
  final Color? triangleColor;
  final PaintingStyle? arcBgStyle;
  final StrokeCap? arcBgStroke;
  final double? arcBgWidth;
  final PaintingStyle? arcFrStyle;
  final StrokeCap? arcFrStroke;
  final double? arcFrWidth;
  final double? triangleSize;
  final double? triangleGap;

  ChargeLeftArcPainter(
      {super.repaint,
      required this.percentage,
      required this.value,
      this.bgColor,
      this.frColor,
      this.triangleColor,
      this.triangleGap,
      this.triangleSize,
      this.arcBgWidth,
      this.arcBgStroke,
      this.arcBgStyle,
      this.arcFrWidth,
      this.arcFrStroke,
      this.arcFrStyle});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;

    final double arcRadius = w * 2;

    // const triangleGap = 5.0; // Distance from arc
    // const triangleSize = 10.0; // Side length of triangl
    final center = Offset(w / 2, arcRadius);

    final Paint arcBgPaint = Paint()
      ..color = bgColor ?? Colors.white
      ..style = arcBgStyle ?? PaintingStyle.stroke
      ..strokeCap = arcBgStroke ?? StrokeCap.round
      ..strokeWidth = arcBgWidth ?? 10;
    final Paint arcFrLeftPaint = Paint()
      ..color = frColor ?? Colors.green
      ..style = arcFrStyle ?? PaintingStyle.stroke
      ..strokeCap = arcFrStroke ?? StrokeCap.round
      ..strokeWidth = arcFrWidth ?? 10;
    final Paint arcFrRightPaint = Paint()
      ..color = frColor ?? Colors.red
      ..style = arcFrStyle ?? PaintingStyle.stroke
      ..strokeCap = arcFrStroke ?? StrokeCap.round
      ..strokeWidth = arcFrWidth ?? 10;

    //Left Arc

    final Rect arcRect = Rect.fromCircle(center: center, radius: arcRadius);
    const double startAngle = 260;
    // 180 + 80;
    const double sweepAngle = 18;
    final getAnglePercentage = (value / 100) * sweepAngle;
    final animateAngle = getAnglePercentage * percentage;

    // Update this line:

    final triangleAngle = startAngle + animateAngle;

    //Right Arc
    const double startAngleRight = 280;
    const double sweepAngleRight = -18;
    final getAnglePercentageRight = (value / 100) * sweepAngleRight;

    //Backgroud Arc

    canvas.drawArc(arcRect, angleToRadians(startAngle), angleToRadians(20),
        false, arcBgPaint..color = Colors.grey);

    //Left arc backgroud
    canvas.drawArc(arcRect, angleToRadians(startAngle), angleToRadians(9.5),
        false, arcBgPaint..color = Colors.white);
    //Left arc foreground
    canvas.drawArc(arcRect, angleToRadians(startAngle),
        angleToRadians(getAnglePercentage * percentage), false, arcFrLeftPaint);

    //Right arc backgroud
    canvas.drawArc(arcRect, angleToRadians(startAngleRight),
        angleToRadians(-9.5), false, arcBgPaint..color = Colors.white);
    //Right arc foreground
    canvas.drawArc(
        arcRect,
        angleToRadians(startAngleRight),
        angleToRadians(getAnglePercentageRight * percentage),
        false,
        arcFrRightPaint);

    // Draw triangle outside arc, rotating with angle
    drawRotatingTriangle(
      canvas: canvas,
      center: center,
      arcRadius: arcRadius,
      arcStrokeWidth: arcFrWidth ?? 10,
      triangleGap: triangleGap ?? 10,
      triangleSize: triangleSize ?? 10,
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
      ..color = triangleColor ?? Colors.yellow
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
