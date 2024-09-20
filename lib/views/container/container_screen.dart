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

  String get _generatedCode => '''
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: $_width,
      height: $_height,
      decoration: BoxDecoration(
        color: Color(0x${_color.value.toRadixString(16).padLeft(8, '0')}),
        borderRadius: BorderRadius.circular($_borderRadius),
      ),
    );
  }
}
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Container')),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Dynamic UI section
                Expanded(
                  child: Center(
                    child: Container(
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(_borderRadius),
                      ),
                    ),
                  ),
                ),
                // UI control section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Width: ${_width.toStringAsFixed(0)}'),
                        Slider(
                          value: _width,
                          min: 50,
                          max: 300,
                          onChanged: (value) => setState(() => _width = value),
                        ),
                        Text('Height: ${_height.toStringAsFixed(0)}'),
                        Slider(
                          value: _height,
                          min: 50,
                          max: 300,
                          onChanged: (value) => setState(() => _height = value),
                        ),
                        Text(
                            'Border Radius: ${_borderRadius.toStringAsFixed(0)}'),
                        Slider(
                          value: _borderRadius,
                          min: 0,
                          max: 150,
                          onChanged: (value) =>
                              setState(() => _borderRadius = value),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => setState(() => _color =
                              Colors.primaries[
                                  _color.value % Colors.primaries.length]),
                          child: const Text('Change Color'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Code editor section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                border: Border(top: BorderSide(color: Colors.grey[800]!)),
              ),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.grey[800],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Generated Code',
                            style: TextStyle(color: Colors.white)),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.copy),
                          label: const Text('Copy'),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: _generatedCode));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Code copied to clipboard')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.firaCode(fontSize: 14),
                            children: _highlightSyntax(_generatedCode),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _highlightSyntax(String code) {
    final keywords = [
      'class',
      'extends',
      'StatelessWidget',
      'Widget',
      'build',
      'return',
      'const'
    ];
    final types = ['Container', 'BoxDecoration', 'BorderRadius', 'Color'];

    return code.split(' ').map((word) {
      if (keywords.contains(word)) {
        return TextSpan(
            text: '$word ', style: TextStyle(color: Colors.pink[300]));
      } else if (types.contains(word)) {
        return TextSpan(
            text: '$word ', style: TextStyle(color: Colors.cyan[300]));
      } else if (word.startsWith('@')) {
        return TextSpan(
            text: '$word ', style: TextStyle(color: Colors.blue[300]));
      } else if (word.startsWith('//')) {
        return TextSpan(
            text: '$word ', style: TextStyle(color: Colors.green[300]));
      } else {
        return TextSpan(
            text: '$word ', style: TextStyle(color: Colors.grey[300]));
      }
    }).toList();
  }
}
