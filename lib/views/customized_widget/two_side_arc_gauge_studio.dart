import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_canvas/component/code_section.dart';
import 'package:flutter_canvas/component/edit_section_title.dart';
import 'package:flutter_canvas/views/customized_widget/two_side_arc_gauge_screen.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

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
                                              _buildStatItem(
                                                icon: Icons.height,
                                                label: 'Height',
                                                value:
                                                    '${_height.toStringAsFixed(0)}px',
                                                theme: theme,
                                              ),
                                              const SizedBox(width: 16),
                                              _buildStatItem(
                                                icon: Icons.width_normal,
                                                label: 'Width',
                                                value:
                                                    '${_width.toStringAsFixed(0)}px',
                                                theme: theme,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              _buildStatItem(
                                                icon: Icons.arrow_upward,
                                                label: 'Left Max',
                                                value: '35 PSI',
                                                theme: theme,
                                              ),
                                              const SizedBox(width: 16),
                                              _buildStatItem(
                                                icon: Icons.arrow_upward,
                                                label: 'Right Max',
                                                value: '35 PSI',
                                                theme: theme,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              _buildStatItem(
                                                icon: Icons.speed,
                                                label: 'Left Current',
                                                value: '29 PSI',
                                                theme: theme,
                                                valueColor: Colors.green,
                                              ),
                                              const SizedBox(width: 16),
                                              _buildStatItem(
                                                icon: Icons.speed,
                                                label: 'Right Current',
                                                value: '31 PSI',
                                                theme: theme,
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
                                    _buildSlider('Width', _width, 50, 300,
                                        (val) {
                                      setState(() => _width = val);
                                    }, theme),
                                    _buildSlider('Height', _height, 50, 300,
                                        (val) {
                                      setState(() => _height = val);
                                    }, theme),
                                  ],
                                ),
                              ),
                              EditSectionTitle(
                                title: 'Appearance',
                                displayWidget: Column(
                                  children: [
                                    _buildColorPicker('Color', _color, (val) {
                                      setState(() => _color = val);
                                    }, theme),
                                    _buildSlider('Opacity', _opacity, 0, 1,
                                        (val) {
                                      setState(() => _opacity = val);
                                    }, theme),
                                    _buildSlider(
                                        'Border Radius', _borderRadius, 0, 150,
                                        (val) {
                                      setState(() => _borderRadius = val);
                                    }, theme),
                                  ],
                                ),
                              ),
                              EditSectionTitle(
                                title: 'Border',
                                displayWidget: Column(
                                  children: [
                                    _buildColorPicker(
                                        'Border Color', _borderColor, (val) {
                                      setState(() => _borderColor = val);
                                    }, theme),
                                    _buildSlider(
                                        'Border Width', _borderWidth, 0, 10,
                                        (val) {
                                      setState(() => _borderWidth = val);
                                    }, theme),
                                  ],
                                ),
                              ),
                              EditSectionTitle(
                                title: 'Effects',
                                displayWidget: Column(
                                  children: [
                                    _buildSlider(
                                        'Rotation (°)', _rotation, 0, 360,
                                        (val) {
                                      setState(() => _rotation = val);
                                    }, theme),
                                    _buildSwitchOption('Shadow', _hasShadow,
                                        (val) {
                                      setState(() => _hasShadow = val);
                                    }, theme),
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

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium, // Use theme text style
            ),
            Text(
              value.toStringAsFixed(1),
              style: theme.textTheme.bodyMedium, // Use theme text style
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            // Copy from context and override
            activeTrackColor: theme.colorScheme.primary,
            inactiveTrackColor: theme.colorScheme.primary.withOpacity(0.3),
            thumbColor: theme.colorScheme
                .onPrimary, // Or theme.colorScheme.primary for a solid thumb
            overlayColor: theme.colorScheme.primary.withOpacity(0.2),
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker(
      String label, Color color, Function(Color) onChanged, ThemeData theme) {
    // ... existing code ...
    final List<Color> colors = [
      // Keep this list or make it themeable if desired
      Colors.red, Colors.pink, Colors.purple, Colors.deepPurple, Colors.indigo,
      Colors.blue, Colors.lightBlue, Colors.cyan, Colors.teal, Colors.green,
      Colors.lightGreen, Colors.lime, Colors.yellow, Colors.amber,
      Colors.orange,
      Colors.deepOrange, Colors.brown, Colors.grey, Colors.blueGrey,
      Colors.black, Colors.white,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium, // Use theme text style
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: theme.colorScheme.onSurface.withOpacity(0.5)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onChanged(colors[index]),
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: colors[index] == color
                          ? theme.colorScheme
                              .primary // Highlight selected color with theme primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchOption(
      String label, bool value, Function(bool) onChanged, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    value ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: value
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: theme.colorScheme.primary,
                  activeTrackColor: theme.colorScheme.primary.withOpacity(0.3),
                  inactiveThumbColor:
                      theme.colorScheme.onSurface.withOpacity(0.5),
                  inactiveTrackColor:
                      theme.colorScheme.onSurface.withOpacity(0.1),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildStatItem({
  IconData? icon,
  required String label,
  required String value,
  required ThemeData theme,
  Color? valueColor,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: theme.colorScheme.outline.withOpacity(0.2),
      ),
      boxShadow: [
        BoxShadow(
          color: theme.shadowColor.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            if (icon != null) const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ],
    ),
  );
}
