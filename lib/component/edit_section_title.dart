import 'package:flutter/material.dart';

class EditSectionTitle extends StatelessWidget {
  final String title;
  final Widget? displayWidget;
  const EditSectionTitle({required this.title, this.displayWidget, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),
            // Use theme text style
          ),
          if (displayWidget != null)
            displayWidget!, // Display the widget if provided
        ],
      ),
    );
  }
}
