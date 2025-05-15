import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor; // Keep specific icon color if needed, or derive from theme
  final VoidCallback onTap;

  const WidgetCard({
    required this.title,
    required this.icon,
    required this.iconColor, // Changed from 'color' to 'iconColor' for clarity
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return SizedBox(
      height: 150,
      width: 120, // Consider making this responsive or part of GridView sizing
      child: GestureDetector(
        onTap: onTap,
        child: Card(
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
      ),
    );
  }
}