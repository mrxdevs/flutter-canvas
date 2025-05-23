import 'package:flutter/material.dart';

class CustomColorPicker extends StatelessWidget {
  final String label;
  final Color selectedColor;
  final Function(Color) onColorChanged;
  final List<Color> colorOptions;

  const CustomColorPicker({
    super.key,
    required this.label,
    required this.selectedColor,
    required this.onColorChanged,
    this.colorOptions = const [
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
    ],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium,
            ),
            Container(
              width: 24,
              height: 24,
              // margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: selectedColor,
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
            itemCount: colorOptions.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onColorChanged(colorOptions[index]),
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: colorOptions[index],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: colorOptions[index] == selectedColor
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
