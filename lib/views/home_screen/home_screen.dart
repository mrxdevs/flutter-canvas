import 'package:flutter/material.dart';
import 'package:flutter_canvas/providers/theme_notifier.dart';
import 'package:flutter_canvas/views/home_screen/components/comman_widget_section.dart'; // Assuming this is your custom widget section
import 'package:flutter_canvas/views/home_screen/components/customized_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "/home_screen";

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      // backgroundColor is now handled by the theme
      appBar: AppBar(
        // backgroundColor and titleTextStyle are now handled by the theme's AppBarTheme
        title: const Text(
          'Flutter Canvas Studio',
          // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Handled by theme
        ),
        // elevation: 0, // Handled by theme
        actions: [
          IconButton(
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
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommanWidgetSection(),
                SizedBox(height: 50),
                CustomizedWidgetSection() // Ensure this widget also adapts to theme changes
              ],
            ),
          ),
        ),
      ),
    );
  }
}
