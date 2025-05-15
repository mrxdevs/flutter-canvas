import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({Key? key}) : super(key: key);

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  double _width = 200;
  double _height = 200;
  Color _color = Colors.blue;
  double _borderRadius = 0;
  double _opacity = 1.0;
  double _rotation = 0.0;
  Color _borderColor = Colors.transparent;
  double _borderWidth = 0;
  List<BoxShadow>? _boxShadow;
  bool _hasShadow = false;

  String get _generatedCode => '''
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: ${_rotation * 3.14159 / 180},
      child: Container(
        width: $_width,
        height: $_height,
        decoration: BoxDecoration(
          color: Color(0x${(_color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}${(_opacity * 255).toInt().toRadixString(16).padLeft(2, '0')}),
          borderRadius: BorderRadius.circular($_borderRadius),
          border: Border.all(
            color: Color(0x${_borderColor.value.toRadixString(16).padLeft(8, '0')}),
            width: $_borderWidth,
          ),
          ${_hasShadow ? 'boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],' : ''}
        ),
      ),
    );
  }
}
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text(
          'Container Studio',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2D2D44),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left panel - Canvas area
                Expanded(
                  flex: 3,
                  child: Container(
                    color: const Color(0xFF2D2D44),
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Transform.rotate(
                        angle: _rotation * 3.14159 / 180,
                        child: Container(
                          width: _width,
                          height: _height,
                          decoration: BoxDecoration(
                            color: _color.withOpacity(_opacity),
                            borderRadius: BorderRadius.circular(_borderRadius),
                            border: Border.all(
                              color: _borderColor,
                              width: _borderWidth,
                            ),
                            boxShadow: _hasShadow
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
                  ),
                ),
                // Right panel - Controls
                Expanded(
                  flex: 2,
                  child: Container(
                    color: const Color(0xFF1E1E2C),
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Dimensions'),
                          _buildSlider('Width', _width, 50, 300, (val) {
                            setState(() => _width = val);
                          }),
                          _buildSlider('Height', _height, 50, 300, (val) {
                            setState(() => _height = val);
                          }),
                          const Divider(color: Color(0xFF3D3D54)),
                          _buildSectionTitle('Appearance'),
                          _buildColorPicker('Color', _color, (val) {
                            setState(() => _color = val);
                          }),
                          _buildSlider('Opacity', _opacity, 0, 1, (val) {
                            setState(() => _opacity = val);
                          }),
                          _buildSlider('Border Radius', _borderRadius, 0, 150, (val) {
                            setState(() => _borderRadius = val);
                          }),
                          const Divider(color: Color(0xFF3D3D54)),
                          _buildSectionTitle('Border'),
                          _buildColorPicker('Border Color', _borderColor, (val) {
                            setState(() => _borderColor = val);
                          }),
                          _buildSlider('Border Width', _borderWidth, 0, 10, (val) {
                            setState(() => _borderWidth = val);
                          }),
                          const Divider(color: Color(0xFF3D3D54)),
                          _buildSectionTitle('Effects'),
                          _buildSlider('Rotation (°)', _rotation, 0, 360, (val) {
                            setState(() => _rotation = val);
                          }),
                          _buildSwitchOption('Shadow', _hasShadow, (val) {
                            setState(() => _hasShadow = val);
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Code section
          Container(
            height: 200,
            color: const Color(0xFF0D0D15),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Generated Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _generatedCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied to clipboard'),
                            backgroundColor: Color(0xFF2D2D44),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2C),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _generatedCode,
                        style: const TextStyle(
                          color: Color(0xFFB8B8D2),
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0xFFB8B8D2)),
            ),
            Text(
              value.toStringAsFixed(1),
              style: const TextStyle(color: Color(0xFFB8B8D2)),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: const Color(0xFF3D3D54),
            thumbColor: Colors.white,
            overlayColor: Colors.blue.withOpacity(0.2),
            trackHeight: 4,
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

  Widget _buildColorPicker(String label, Color color, Function(Color) onChanged) {
    final List<Color> colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0xFFB8B8D2)),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white30),
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
                          ? Colors.white
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

  Widget _buildSwitchOption(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFB8B8D2)),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}
