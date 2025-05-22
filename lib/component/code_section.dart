import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CodeSection extends StatefulWidget {
  final double height;
  final Function(double) onHeightChanged;
  final String markdownCode;
  final String Function() markdownData;

  const CodeSection({
    super.key,
    required this.height,
    required this.onHeightChanged,
    required this.markdownCode,
    required this.markdownData,
  });

  @override
  State<CodeSection> createState() => _CodeSectionState();
}

class _CodeSectionState extends State<CodeSection> {
  late double currentHeight;

  @override
  void initState() {
    super.initState();
    currentHeight = widget.height;
  }

  @override
  void didUpdateWidget(CodeSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.height != widget.height) {
      currentHeight = widget.height;
    }
  }

  void _handlePanUpdate(DragUpdateDetails dragUpdate) {
    setState(() {
      currentHeight = (currentHeight - dragUpdate.delta.dy).clamp(
        100.0,
        MediaQuery.of(context).size.height,
      );
      widget.onHeightChanged(currentHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onPanUpdate: _handlePanUpdate,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(
          minHeight: 100,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        height: currentHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          border: Border.all(
            color: theme.dividerColor.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Code Preview',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.drag_handle_outlined),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.code),
                    label: const Text('Copy Code'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: theme.dividerColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      foregroundColor: theme.primaryColorLight,
                      backgroundColor: Colors.transparent,
                      iconColor: theme.primaryColorLight,
                      textStyle: TextStyle(color: theme.primaryColorLight),
                    ),
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.markdownCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Code copied to clipboard'),
                          backgroundColor: theme.colorScheme.secondary,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.black,
                child: Markdown(
                  selectable: true,
                  data: widget.markdownData(),
                  styleSheet: MarkdownStyleSheet(
                    code: TextStyle(
                      color: theme.primaryColorLight,
                      fontSize: 16,
                      backgroundColor: Colors.transparent,
                    ),
                    codeblockDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
