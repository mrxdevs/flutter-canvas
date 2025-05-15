import 'package:flutter/material.dart';
import 'package:flutter_canvas/helper/route_helper.dart';
import 'package:flutter_canvas/providers/theme_notifier.dart';
// import 'package:flutter_canvas/views/home_screen/home_screen.dart'; // Assuming initialRoute handles this
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Flutter Canvas Studio',
      theme: themeNotifier.currentTheme, // Use the current theme from notifier
      // darkTheme: AppThemes.darkTheme, // You can still define a specific darkTheme if needed for system settings
      // themeMode: themeNotifier.themeMode, // Or manage themeMode directly
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.homeScreen,
      routes: RouteHelper.routes,
      // home: const HomeScreen(), // initialRoute should handle this
    );
  }
}
