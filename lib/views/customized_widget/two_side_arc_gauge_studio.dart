import 'package:flutter/material.dart';

import 'package:flutter_canvas/component/code_section.dart';
import 'package:flutter_canvas/component/edit_section_title.dart';
import 'package:flutter_canvas/component/slider_widget.dart';
import 'package:flutter_canvas/views/customized_widget/two_side_arc_gauge_screen.dart';
import 'package:provider/provider.dart';

import '../../component/custom_color_picker.dart';
import '../../component/custom_switch_widget.dart';
import '../../component/stats_card.dart';
import '../../providers/theme_notifier.dart'; // For min/max and angle conversion

// Enum for code overlay state
enum CodeOverlayState { hidden, normal, maximized }

class TwoSideArcGaugeStudio extends StatefulWidget {
  const TwoSideArcGaugeStudio({super.key});

  @override
  State<TwoSideArcGaugeStudio> createState() => _TwoSideArcGaugeStudioState();
}

class _TwoSideArcGaugeStudioState extends State<TwoSideArcGaugeStudio> {
  double _width = 200;
  double _height = 200;
  Color _color = Colors.blue;
  double _borderRadius = 0;
  double _opacity = 1.0;
  double _rotation = 0.0;
  Color _borderColor = Colors.transparent;
  double _borderWidth = 0;
  // List<BoxShadow>? _boxShadow; // Not used in generated code, can be removed if not planned
  bool _hasShadow = false;

  // variable for stats
  bool isShowStats = false;

  //Coding tab variables
  double codingBoxheight = 100;

  final String _markdownCode = """
```dart
import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color
      iconColor; // Keep specific icon color if needed, or derive from theme
  final VoidCallback onTap;
  final Widget? displayWidget;

  const WidgetCard({
    required this.title,
    required this.icon,
    required this.iconColor, // Changed from 'color' to 'iconColor' for clarity
    required this.onTap,
    super.key,
    this.displayWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return SizedBox(
      height: 150,
      width: 150, // Consider making this responsive or part of GridView sizing
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            displayWidget ?? const SizedBox(),
            Card(
              // CardTheme from AppThemes will be applied here
              // elevation: 5, // Handled by CardTheme
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Handled by CardTheme
              // color: const Color(0xFF2D2D44), // Handled by CardTheme
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        // Use a color derived from the theme or a fixed one if it's brand-specific
                        color: iconColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, size: 40, color: iconColor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        // color: Colors.white, // Handled by TextTheme in Card
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}""";

  String _markdownData() => """
$_markdownCode

""";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get theme here
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Two Side ARC'), // Style handled by AppBarTheme

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: IconButton(
              icon: Icon(
                themeNotifier.isDarkMode
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
              ),
              onPressed: () {
                themeNotifier.toggleTheme();
              },
              tooltip: 'Toggle Theme',
            ),
          ),
        ],
      ),
      body: Stack(
        // Use Stack to overlay the code window
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Left panel - Canvas area
                    Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: const TyrePressureAnimationWidget(
                                rearTyrePressure: 29,
                                frontTyrePressure: 31,
                                bgColor: Colors.grey,
                                sideBgColor: Colors.white,
                                arrowSide: ArrowSide.left,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  // color: theme.colorScheme.surface
                                  //     .withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (isShowStats)
                                      Column(
                                        children: [
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              StatItem(
                                                icon: Icons.height,
                                                label: 'Height',
                                                value:
                                                    '${_height.toStringAsFixed(0)}px',
                                              ),
                                              const SizedBox(width: 16),
                                              StatItem(
                                                icon: Icons.width_normal,
                                                label: 'Width',
                                                value:
                                                    '${_width.toStringAsFixed(0)}px',
                                              ),
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
                                    // Add more stats here if needed

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Stats',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Switch(
                                            value: isShowStats,
                                            onChanged: (val) {
                                              setState(() {
                                                isShowStats = val;
                                              });
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    // Right panel - Controls
                    Expanded(
                      flex: 2,
                      child: Container(
                        // color: const Color(0xFF1E1E2C), // Handled by theme (Scaffold background)
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditSectionTitle(
                                title: 'Dimensions',
                                displayWidget: Column(
                                  children: [
                                    CustomSliderWidget(
                                      label: "Width",
                                      value: _width,
                                      min: 50,
                                      max: 300,
                                      onChanged: (val) {
                                        setState(() => _width = val);
                                      },
                                    ),
                                    CustomSliderWidget(
                                      label: "Height",
                                      value: _height,
                                      min: 50,
                                      max: 300,
                                      onChanged: (val) {
                                        setState(() => _height = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              EditSectionTitle(
                                title: 'Appearance',
                                displayWidget: Column(
                                  children: [
                                    CustomColorPicker(
                                      label: 'Color',
                                      selectedColor: _color,
                                      onColorChanged: (val) {
                                        setState(() => _color = val);
                                      },
                                    ),
                                    CustomSliderWidget(
                                      label: "Opacity",
                                      value: _opacity,
                                      min: 0,
                                      max: 1,
                                      onChanged: (val) {
                                        setState(() => _opacity = val);
                                      },
                                    ),
                                    CustomSliderWidget(
                                      label: "Border Radius",
                                      value: _borderRadius,
                                      min: 0,
                                      max: 150,
                                      onChanged: (val) {
                                        setState(() => _borderRadius = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              EditSectionTitle(
                                title: 'Border',
                                displayWidget: Column(
                                  children: [
                                    CustomColorPicker(
                                      label: 'Border Color',
                                      selectedColor: _borderColor,
                                      onColorChanged: (val) {
                                        setState(() => _borderColor = val);
                                      },
                                    ),
                                    CustomSliderWidget(
                                      label: "Border Width",
                                      value: _borderWidth,
                                      min: 0,
                                      max: 10,
                                      onChanged: (val) {
                                        setState(() => _borderWidth = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              EditSectionTitle(
                                title: 'Effects',
                                displayWidget: Column(
                                  children: [
                                    CustomSliderWidget(
                                      label: "Rotation (°)",
                                      value: _rotation,
                                      min: 0,
                                      max: 360,
                                      onChanged: (val) {
                                        setState(() => _rotation = val);
                                      },
                                    ),
                                    CustomSwitchOption(
                                      label: 'Shadow',
                                      value: _hasShadow,
                                      onChanged: (val) {
                                        setState(() => _hasShadow = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              )
              // "View Code" button section
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              // child: codingSection(context, theme),
              child: CodeSection(
                  height: codingBoxheight,
                  onHeightChanged: (changedHight) {
                    setState(() {
                      codingBoxheight = changedHight;
                    });
                  },
                  markdownCode: _markdownCode,
                  markdownData: _markdownData),
            ),
          ),

          // _buildCodeOverlay(context), // Add the overlay to the stack
        ],
      ),
    );
  }
}
