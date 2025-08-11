import 'package:flutter/material.dart';
import 'package:flutter_canvas/component/custom_color_picker.dart';
import 'package:flutter_canvas/component/custom_switch_widget.dart';
import 'package:flutter_canvas/component/stats_card.dart';
import 'package:flutter_canvas/providers/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'package:flutter_canvas/component/code_section.dart';
import 'package:flutter_canvas/component/edit_section_title.dart';
import 'package:flutter_canvas/component/slider_widget.dart';

import 'charge_left_arc_screen.dart';

enum CodeOverlayState { hidden, normal, maximized }

class ChargeLeftArcStudio extends StatefulWidget {
  const ChargeLeftArcStudio({super.key});

  @override
  State<ChargeLeftArcStudio> createState() => _ChargeLeftArcStudioState();
}

class _ChargeLeftArcStudioState extends State<ChargeLeftArcStudio> {
  double width = 600;
  double height = 600;
  Color color = Colors.blue;
  double borderRadius = 0;
  double opacity = 1.0;
  double rotation = 0.0;
  Color borderColor = Colors.transparent;
  double borderWidth = 0;
  bool hasShadow = false;
  bool showStats = false;
  double codeSectionHeight = 100;

  late double maxWidth;
  late double maxHeight;

  double _rearTyrePressure = 31;
  double _frontTyrePressure = 29;
  double _arrowMax = 29;
  double _arrowCurrent = 29;
  double _leftMax = 29;
  double _rightMax = 31;
  bool isLeftArrow = true;
  bool newCanvas = false;

  final _arcController = ChargeLeftArcController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenSize = MediaQuery.of(context).size;

    maxWidth = (screenSize.width * 0.6) - 64;
    maxHeight = screenSize.height - 200;

    maxWidth = maxWidth.clamp(300, 1000);
    maxHeight = maxHeight.clamp(300, 800);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charge Left'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: IconButton(
              icon: Icon(themeNotifier.isDarkMode
                  ? Icons.wb_sunny
                  : Icons.nightlight_round),
              onPressed: themeNotifier.toggleTheme,
              tooltip: 'Toggle Theme',
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: _StudioCanvas(
                                  width: width,
                                  height: height,
                                  child: ChargeLeftArc(
                                    value: 50,
                                    controller: _arcController,
                                  ),
                                ),
                              ),
                            ),
                            _statsUI(theme),
                            IconButton(
                                onPressed: () {
                                  _arcController.replay();
                                },
                                icon: const Icon(Icons.restart_alt))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _StudioControls(
                        width: width,
                        height: height,
                        color: color,
                        isLeftArrow: isLeftArrow,
                        borderRadius: borderRadius,
                        opacity: opacity,
                        rotation: rotation,
                        borderColor: borderColor,
                        borderWidth: borderWidth,
                        hasShadow: hasShadow,
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        arrowMax: _arrowMax,
                        arrowCurrent: _arrowCurrent,
                        leftMax: _leftMax,
                        rightMax: _rightMax,
                        leftCurrent: _frontTyrePressure,
                        rightCurrent: _rearTyrePressure,
                        onWidthChanged: (val) => setState(() => width = val),
                        onHeightChanged: (val) => setState(() => height = val),
                        onColorChanged: (val) => setState(() => color = val),
                        onLeftCurrentChanged: (value) =>
                            setState(() => _frontTyrePressure = value),
                        onRightCurrentChanged: (value) =>
                            setState(() => _rearTyrePressure = value),
                        onLeftMaxChanged: (value) =>
                            setState(() => _leftMax = value),
                        onRightMaxChanged: (value) =>
                            setState(() => _rightMax = value),
                        onArrowMaxChanged: (value) =>
                            setState(() => _arrowMax = value),
                        onArrowCurrentChanged: (value) =>
                            setState(() => _arrowCurrent = value),
                        onArrowSideChanged: (value) =>
                            setState(() => isLeftArrow = value),
                        onBorderRadiusChanged: (val) =>
                            setState(() => borderRadius = val),
                        onOpacityChanged: (val) =>
                            setState(() => opacity = val),
                        onRotationChanged: (val) =>
                            setState(() => rotation = val),
                        onBorderColorChanged: (val) =>
                            setState(() => borderColor = val),
                        onBorderWidthChanged: (val) =>
                            setState(() => borderWidth = val),
                        onShadowChanged: (val) =>
                            setState(() => hasShadow = val),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CodeSection(
                height: codeSectionHeight,
                onHeightChanged: (h) => setState(() => codeSectionHeight = h),
                markdownCode: _generateCode(),
                markdownData: () => _generateCode(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _statsUI(ThemeData theme) {
    return Positioned(
      bottom: 20,
      left: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (showStats)
              Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      StatItem(
                          icon: Icons.height,
                          label: 'Height',
                          value: '${height.toStringAsFixed(0)}px'),
                      const SizedBox(width: 16),
                      StatItem(
                          icon: Icons.width_normal,
                          label: 'Width',
                          value: '${width.toStringAsFixed(0)}px'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      StatItem(
                        icon: Icons.arrow_upward,
                        label: 'Left Max',
                        value: '35 PSI',
                      ),
                      SizedBox(width: 16),
                      StatItem(
                        icon: Icons.arrow_upward,
                        label: 'Right Max',
                        value: '35 PSI',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      StatItem(
                        icon: Icons.speed,
                        label: 'Left Current',
                        value: '29 PSI',
                        valueColor: Colors.green,
                      ),
                      SizedBox(width: 16),
                      StatItem(
                        icon: Icons.speed,
                        label: 'Right Current',
                        value: '31 PSI',
                        valueColor: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Stats',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 20),
                  Switch(
                      thumbColor: MaterialStatePropertyAll(Colors.white),
                      value: showStats,
                      onChanged: (va) {
                        setState(() {
                          showStats = !showStats;
                        });
                      }),
                ],
              ),
              const SizedBox(width: 20),
            ]),
          ],
        ),
      ),
    );
  }

  String _generateCode() {
    return '...';
  }
}

class _StudioCanvas extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  const _StudioCanvas({
    Key? key,
    required this.width,
    required this.height,
    this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.primaryColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: child ?? const SizedBox()),
      ],
    );
  }
}

class _StudioControls extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final double opacity;
  final double rotation;
  final Color borderColor;
  final double borderWidth;
  final bool hasShadow;
  final double maxWidth;
  final double maxHeight;
  final double arrowMax;
  final double arrowCurrent;
  final double leftMax;
  final double rightMax;
  final double leftCurrent;
  final double rightCurrent;
  final bool? isLeftArrow;
  final ValueChanged<double> onWidthChanged;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onBorderRadiusChanged;
  final ValueChanged<double> onOpacityChanged;
  final ValueChanged<double> onRotationChanged;
  final ValueChanged<Color> onBorderColorChanged;
  final ValueChanged<double> onBorderWidthChanged;
  final ValueChanged<bool> onShadowChanged;
  final ValueChanged<double>? onLeftMaxChanged;
  final ValueChanged<double>? onRightMaxChanged;
  final ValueChanged<double>? onLeftCurrentChanged;
  final ValueChanged<double>? onRightCurrentChanged;
  final ValueChanged<double>? onArrowMaxChanged;
  final ValueChanged<double>? onArrowCurrentChanged;
  final ValueChanged<bool>? onArrowSideChanged;

  const _StudioControls({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
    required this.opacity,
    required this.rotation,
    required this.borderColor,
    required this.borderWidth,
    required this.hasShadow,
    required this.maxWidth,
    required this.maxHeight,
    required this.arrowMax,
    required this.arrowCurrent,
    required this.leftMax,
    required this.rightMax,
    required this.leftCurrent,
    required this.rightCurrent,
    required this.onWidthChanged,
    required this.onHeightChanged,
    required this.onColorChanged,
    required this.onBorderRadiusChanged,
    required this.onOpacityChanged,
    required this.onRotationChanged,
    required this.onBorderColorChanged,
    required this.onBorderWidthChanged,
    required this.onShadowChanged,
    this.onLeftMaxChanged,
    this.onRightMaxChanged,
    this.onLeftCurrentChanged,
    this.onRightCurrentChanged,
    this.onArrowMaxChanged,
    this.onArrowCurrentChanged,
    this.isLeftArrow,
    this.onArrowSideChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditSectionTitle(
              title: 'Box Dimensions',
              displayWidget: Column(
                children: [
                  CustomSliderWidget(
                      label: 'Box Width ',
                      value: width,
                      min: 0,
                      max: maxWidth,
                      onChanged: onWidthChanged),
                  CustomSliderWidget(
                      label: 'Box Height',
                      value: height,
                      min: 0,
                      max: maxHeight,
                      onChanged: onHeightChanged),
                  Row(
                    children: [
                      Expanded(
                        child: CustomSliderWidget(
                            label: 'Left Max ',
                            value: leftMax,
                            min: 0,
                            max: 50,
                            onChanged: onLeftMaxChanged ?? (_) {}),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomSliderWidget(
                            label: "Left Current",
                            value:
                                leftMax > leftCurrent ? leftCurrent : leftMax,
                            min: 0,
                            max: leftMax,
                            onChanged: onLeftCurrentChanged ?? (_) {}),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomSliderWidget(
                            label: 'Right Max ',
                            value: rightMax,
                            min: 0,
                            max: 50,
                            onChanged: onRightMaxChanged ?? (_) {}),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomSliderWidget(
                            label: "Right Current",
                            value: rightMax > rightCurrent
                                ? rightCurrent
                                : rightMax,
                            min: 0,
                            max: rightMax,
                            onChanged: onRightCurrentChanged ?? (_) {}),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomSliderWidget(
                            label: 'Arrow Max ',
                            value: arrowMax,
                            min: 0,
                            max: 50,
                            onChanged: onArrowMaxChanged ?? (_) {}),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomSliderWidget(
                            label: "Arrow Current",
                            value: arrowMax > arrowCurrent
                                ? arrowCurrent
                                : arrowMax,
                            min: 0,
                            max: arrowMax,
                            onChanged: onArrowCurrentChanged ?? (_) {}),
                      ),
                    ],
                  ),
                  CustomSwitchOption(
                      label: "Left Arrow",
                      value: isLeftArrow ?? false,
                      onChanged: onArrowSideChanged ?? (_) {})
                ],
              ),
            ),
            EditSectionTitle(
              title: 'Appearance',
              displayWidget: Column(
                children: [
                  CustomColorPicker(
                      label: 'Arrow',
                      selectedColor: color,
                      onColorChanged: onColorChanged),
                  CustomColorPicker(
                      label: 'Arc BG',
                      selectedColor: color,
                      onColorChanged: onColorChanged),
                  CustomColorPicker(
                      label: 'Left FG',
                      selectedColor: color,
                      onColorChanged: onColorChanged),
                  CustomColorPicker(
                      label: 'Left BG',
                      selectedColor: color,
                      onColorChanged: onColorChanged),
                  CustomColorPicker(
                      label: 'Right FG',
                      selectedColor: color,
                      onColorChanged: onColorChanged),
                  CustomColorPicker(
                      label: 'Right BG',
                      selectedColor: color,
                      onColorChanged: onColorChanged),
                  CustomSliderWidget(
                      label: 'Border Radius',
                      value: borderRadius,
                      min: 0,
                      max: 150,
                      onChanged: onBorderRadiusChanged),
                ],
              ),
            ),
            EditSectionTitle(
              title: 'Border',
              displayWidget: Column(
                children: [
                  CustomColorPicker(
                      label: 'Border Color',
                      selectedColor: borderColor,
                      onColorChanged: onBorderColorChanged),
                  CustomSliderWidget(
                      label: 'Border Width',
                      value: borderWidth,
                      min: 0,
                      max: 10,
                      onChanged: onBorderWidthChanged),
                ],
              ),
            ),
            EditSectionTitle(
              title: 'Effects',
              displayWidget: Column(
                children: [
                  CustomSliderWidget(
                      label: 'Rotation (°)',
                      value: rotation,
                      min: 0,
                      max: 360,
                      onChanged: onRotationChanged),
                  CustomSwitchOption(
                      label: 'Shadow',
                      value: hasShadow,
                      onChanged: onShadowChanged),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
