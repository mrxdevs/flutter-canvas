import 'package:flutter/material.dart';

class CustomSwitchOption extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;
  final double scale;
  final EdgeInsetsGeometry padding;

  const CustomSwitchOption({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.scale = 0.8,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
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
                scale: scale,
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
