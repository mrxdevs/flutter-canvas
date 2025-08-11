// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:flutter/material.dart';

class OddoMeterArcController {
  VoidCallback? _replayAnimation;

  void replay() {
    _replayAnimation?.call();
  }
}

class OddoMeterArc extends StatefulWidget {
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
  final OddoMeterArcController? controller;

  const OddoMeterArc({
    super.key,
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
    this.controller,
  });

  @override
  State<OddoMeterArc> createState() => _OddoMeterArcAnimationWidgetState();
}

class _OddoMeterArcAnimationWidgetState extends State<OddoMeterArc>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _roadAnimationController;
  late Animation<double> _animation;
  late Animation<double> _roadAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Controller for the moving road effect
    _roadAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _roadAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _roadAnimationController,
        curve: Curves.linear,
      ),
    );

    widget.controller?._replayAnimation = _replay;
    _animationController.forward();

    // Start the continuous road animation
    _roadAnimationController.repeat();
  }

  @override
  void didUpdateWidget(covariant OddoMeterArc oldWidget) {
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
  void dispose() {
    _animationController.dispose();
    _roadAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          Listenable.merge([_animationController, _roadAnimationController]),
      builder: (context, child) {
        return CustomPaint(
          painter: OddoMeterArcPainter(
            percentage: _animation.value,
            roadAnimationValue: _roadAnimation.value,
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
            arcFrWidth: widget.arcFrWidth,
          ),
        );
      },
    );
  }
}

class OddoMeterArcPainter extends CustomPainter {
  final double percentage;
  final double roadAnimationValue;
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

  OddoMeterArcPainter({
    super.repaint,
    required this.percentage,
    required this.roadAnimationValue,
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
    this.arcFrStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final double arcRadius = w * 2;
    final center = Offset(w / 2, arcRadius);

    // Background arc paint
    final Paint arcBgPaint = Paint()
      ..color = bgColor ?? Colors.black
      ..style = arcBgStyle ?? PaintingStyle.stroke
      ..strokeCap = arcBgStroke ?? StrokeCap.round
      ..strokeWidth = arcBgWidth ?? 40;

    final Rect arcRect = Rect.fromCircle(center: center, radius: arcRadius);
    const double startAngle = 260;
    const double sweepAngle = 20;
    final getAnglePercentage = (value / 100) * sweepAngle;
    final animateAngle = getAnglePercentage * percentage;

    // Draw background arc
    canvas.drawArc(arcRect, angleToRadians(startAngle),
        angleToRadians(sweepAngle), false, arcBgPaint);

    // Draw moving road lines
    _drawRoadLines(canvas, center, arcRadius, startAngle, sweepAngle);
  }

  void _drawRoadLines(Canvas canvas, Offset center, double arcRadius,
      double startAngle, double currentAngle) {
    final Paint roadLinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final Rect arcRect = Rect.fromCircle(center: center, radius: arcRadius);

    // Create multiple moving dashes
    const int numberOfDashes = 8;
    const double dashLength = 2.0; // Length of each dash in degrees
    const double dashGap = 1.5; // Gap between dashes in degrees

    for (int i = 0; i < numberOfDashes; i++) {
      // Calculate the position of each dash with animation offset
      double dashPosition = (roadAnimationValue * (dashLength + dashGap) * 2) +
          (i * (dashLength + dashGap));

      // Wrap around the animation
      dashPosition = dashPosition % (currentAngle + (dashLength + dashGap) * 2);

      double dashStartAngle = startAngle + dashPosition;

      // Only draw if the dash is within the current progress
      if (dashPosition <= currentAngle &&
          dashPosition + dashLength <= currentAngle) {
        canvas.drawArc(
          arcRect,
          angleToRadians(dashStartAngle),
          angleToRadians(dashLength),
          false,
          roadLinePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double angleToRadians(double angle) {
    return angle * (pi / 180);
  }
}
