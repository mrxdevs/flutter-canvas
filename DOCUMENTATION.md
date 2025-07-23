# Flutter Canvas - Deep Dive

Welcome to the deep dive documentation for the Flutter Canvas project. This document provides a comprehensive overview of the project's architecture, components, and functionalities.

## Project Structure

The project is structured as follows:

- `lib/`: Contains all the Dart code for the application.
  - `main.dart`: The entry point of the application.
  - `component/`: Contains common reusable widgets used throughout the application.
  - `constants/`: Contains application-wide constants like colors and styles.
  - `helper/`: Contains helper classes and functions, such as for routing.
  - `providers/`: Contains providers for state management.
  - `themes/`: Contains theme data for the application.
  - `views/`: Contains the different screens and views of the application.

## Components

The `lib/component/` directory contains a set of reusable widgets that are used to build the UI of the application. These widgets are designed to be generic and customizable.

- `code_section.dart`: A widget to display code snippets.
- `custom_color_picker.dart`: A custom color picker widget.
- `custom_switch_widget.dart`: A custom switch widget.
- `edit_section_title.dart`: A title widget for edit sections.
- `slider_widget.dart`: A slider widget for selecting a value from a range.
- `stats_card.dart`: A card widget to display statistics.

## Custom Widgets

The `lib/views/customized_widget/` directory contains more complex and specialized widgets. Each widget has its own directory containing the widget itself, a "studio" screen for customizing it, and sometimes a dedicated screen to display it.

- **Arc Progress Bar:** A circular progress bar with a customizable arc.
- **Charge Left Arc:** A widget to display the remaining charge.
- **Oddo Meter Arc:** A widget that mimics an odometer.
- **Range Mode Arc:** A widget to display different modes in an arc.
- **Two Side Arc Gauge:** A gauge with arcs on two sides.
- **Tyre Pressure Arc:** A widget to display tyre pressure.

## Theming

The application uses a custom theme system defined in `lib/themes/`. The `AppThemes` class defines the light and dark themes for the application. The `ThemeNotifier` in `lib/providers/` is used to switch between themes.

## State Management

The project uses the `provider` package for state management. Providers are used to manage the theme and potentially other application states.

## Routing

Routing is managed by the `RouteHelper` class in `lib/helper/route_helper.dart`. It defines the routes for the different screens in the application.

## Key Methods and Functions

This section details the core methods and functions that are central to the functionality of the Flutter Canvas project. Understanding these will provide insight into how the custom components are built and how the application state is managed.

### The Widget `build` Method

In Flutter, the `build` method is the most crucial function in any widget's lifecycle. Its primary responsibility is to describe the widget's part of the user interface in terms of other, lower-level widgets. The framework calls this method when the widget is first inserted into the tree and whenever the widget's dependencies change.

**Use Case:** Every visual component in this project, from a simple button to a complex `OddoMeterArc`, has a `build` method that constructs its view.

**Example:** Here is how the `ArcProgressBar` might be used within another widget's `build` method.

```dart
// In a screen's build method
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Arc Progress Bar Example')),
    body: Center(
      child: ArcProgressBar(
        value: 0.75, // The progress value (0.0 to 1.0)
        strokeWidth: 15.0,
        color: Colors.teal,
      ),
    ),
  );
}
```

### Custom Painting with `CustomPainter`

For creating truly custom visuals that are not possible with standard widgets, Flutter provides the `CustomPainter` class. This is the cornerstone of the Flutter Canvas Studio project. It allows for direct drawing onto a canvas.

Two methods are essential when extending `CustomPainter`:

1.  `paint(Canvas canvas, Size size)`: This is where all the drawing logic happens. You get a `Canvas` object to draw on and a `Size` object representing the available space.
2.  `shouldRepaint(covariant CustomPainter oldDelegate)`: This is an optimization method. Flutter calls it to decide whether the view needs to be redrawn. You should return `true` if the new painter is different from the old one and requires a repaint.

**Use Case:** All the custom arc and gauge widgets (`ArcProgressBar`, `TyrePressureArc`, etc.) use a `CustomPainter` to draw their unique shapes, arcs, and indicators.

**Example:** A simplified painter for the `ArcProgressBar`.

```dart
import 'dart:math';
import 'package:flutter/material.dart';

class ArcProgressBarPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Color color;

  ArcProgressBarPainter({
    required this.value,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * value;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant ArcProgressBarPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
```

### State Management with `Provider`

To manage application state, such as the current theme or the values of the customizable widgets, this project uses the `provider` package. It allows for a clean separation of business logic from the UI.

**Use Case:** The `ThemeNotifier` allows the user to switch between light and dark modes. Similarly, a `ChangeNotifier` could be used in a "studio" screen to hold the customizable properties of a widget (like color, stroke width, etc.) and update the widget in real-time as the user adjusts sliders or pickers.

**Example:** Accessing the `ThemeNotifier` to toggle the theme.

```dart
// A button widget that toggles the theme
class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the ThemeNotifier from the widget tree
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return IconButton(
      icon: Icon(
        themeNotifier.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
      ),
      onPressed: () {
        // Call the method on the notifier to change the state
        themeNotifier.toggleTheme();
      },
    );
  }
}
```

### Utility and Helper Functions

The `lib/helper/` directory contains standalone functions and classes that perform common tasks, promoting code reuse and better organization.

**Use Case:** The `RouteHelper` class centralizes navigation logic. Instead of scattering route definitions throughout the code, they are all managed in one place. This makes it easy to add, remove, or modify routes.

**Example:** A snippet from a potential `RouteHelper`.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_canvas/views/home_screen.dart';
import 'package:flutter_canvas/views/customized_widget/arc_progress_bar/arc_progress_bar_studio.dart';

class RouteHelper {
  static const String home = '/';
  static const String arcProgressBarStudio = '/arc-progress-bar-studio';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case arcProgressBarStudio:
        return MaterialPageRoute(builder: (_) => ArcProgressBarStudio());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
```

## How to Run the Project

1.  Clone the repository:
    ```bash
    git clone https://github.com/mrxdevs/flutter-canvas.git
    ```
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the application:
    ```bash
    flutter run
    ```
