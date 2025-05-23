import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../component/code_section.dart';
import '../../../component/edit_section_title.dart';
import '../../../component/slider_widget.dart';
import '../../../component/custom_color_picker.dart';
import '../../../component/custom_switch_widget.dart';
import '../../../providers/theme_notifier.dart';
import 'package:provider/provider.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  double width = 200;
  double height = 200;
  Color color = Colors.blue;
  double borderRadius = 0;
  double opacity = 1.0;
  double rotation = 0.0;
  Color borderColor = Colors.transparent;
  double borderWidth = 0;
  bool hasShadow = false;
  double codeSectionHeight = 120;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Studio'),
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
                      child: _ContainerStudioCanvas(
                        width: width,
                        height: height,
                        color: color,
                        borderRadius: borderRadius,
                        opacity: opacity,
                        rotation: rotation,
                        borderColor: borderColor,
                        borderWidth: borderWidth,
                        hasShadow: hasShadow,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _ContainerStudioControls(
                        width: width,
                        height: height,
                        color: color,
                        borderRadius: borderRadius,
                        opacity: opacity,
                        rotation: rotation,
                        borderColor: borderColor,
                        borderWidth: borderWidth,
                        hasShadow: hasShadow,
                        onWidthChanged: (val) => setState(() => width = val),
                        onHeightChanged: (val) => setState(() => height = val),
                        onColorChanged: (val) => setState(() => color = val),
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

  String _generateCode() {
    return '''
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: ${rotation * 3.14159 / 180},
      child: Container(
        width: $width,
        height: $height,
        decoration: BoxDecoration(
          color: Color(0x${(color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}${(opacity * 255).toInt().toRadixString(16).padLeft(2, '0')}),
          borderRadius: BorderRadius.circular($borderRadius),
          border: Border.all(
            color: Color(0x${borderColor.value.toRadixString(16).padLeft(8, '0')}),
            width: $borderWidth,
          ),
          ${hasShadow ? 'boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],' : ''}
        ),
      ),
    );
  }
}
''';
  }
}

class _ContainerStudioCanvas extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final double opacity;
  final double rotation;
  final Color borderColor;
  final double borderWidth;
  final bool hasShadow;
  const _ContainerStudioCanvas({
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
    required this.opacity,
    required this.rotation,
    required this.borderColor,
    required this.borderWidth,
    required this.hasShadow,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Transform.rotate(
          angle: rotation * 3.14159 / 180,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor,
                width: borderWidth,
              ),
              boxShadow: hasShadow
                  ? [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContainerStudioControls extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final double opacity;
  final double rotation;
  final Color borderColor;
  final double borderWidth;
  final bool hasShadow;
  final ValueChanged<double> onWidthChanged;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onBorderRadiusChanged;
  final ValueChanged<double> onOpacityChanged;
  final ValueChanged<double> onRotationChanged;
  final ValueChanged<Color> onBorderColorChanged;
  final ValueChanged<double> onBorderWidthChanged;
  final ValueChanged<bool> onShadowChanged;
  const _ContainerStudioControls({
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
    required this.opacity,
    required this.rotation,
    required this.borderColor,
    required this.borderWidth,
    required this.hasShadow,
    required this.onWidthChanged,
    required this.onHeightChanged,
    required this.onColorChanged,
    required this.onBorderRadiusChanged,
    required this.onOpacityChanged,
    required this.onRotationChanged,
    required this.onBorderColorChanged,
    required this.onBorderWidthChanged,
    required this.onShadowChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EditSectionTitle(title: 'Dimensions'),
            CustomSliderWidget(
              label: 'Width',
              value: width,
              min: 50,
              max: 300,
              onChanged: onWidthChanged,
            ),
            CustomSliderWidget(
              label: 'Height',
              value: height,
              min: 50,
              max: 300,
              onChanged: onHeightChanged,
            ),
            const Divider(),
            const EditSectionTitle(title: 'Appearance'),
            CustomColorPicker(
                label: 'Border Color',
                selectedColor: borderColor,
                onColorChanged: onBorderColorChanged),
            CustomSliderWidget(
              label: 'Opacity',
              value: opacity,
              min: 0,
              max: 1,
              onChanged: onOpacityChanged,
            ),
            CustomSliderWidget(
              label: 'Border Radius',
              value: borderRadius,
              min: 0,
              max: 150,
              onChanged: onBorderRadiusChanged,
            ),
            const Divider(),
            const EditSectionTitle(title: 'Border'),
            CustomColorPicker(
                label: 'Border Color',
                selectedColor: borderColor,
                onColorChanged: onBorderColorChanged),
            CustomSliderWidget(
              label: 'Border Width',
              value: borderWidth,
              min: 0,
              max: 10,
              onChanged: onBorderWidthChanged,
            ),
            const Divider(),
            const EditSectionTitle(title: 'Effects'),
            CustomSliderWidget(
              label: 'Rotation (°)',
              value: rotation,
              min: 0,
              max: 360,
              onChanged: onRotationChanged,
            ),
            CustomSwitchOption(
                label: 'Shadow', value: hasShadow, onChanged: onShadowChanged),
          ],
        ),
      ),
    );
  }
}
