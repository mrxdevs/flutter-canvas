# Flutter Canvas Studio

Welcome to the Flutter Canvas Studio, a showcase of custom widgets and interactive UI components built with Flutter's powerful canvas API. This project serves as a comprehensive guide and boilerplate for developers looking to create stunning, high-performance animations and visualizations.

## 🚀 Getting Started

To get started with this project, clone the repository and install the dependencies:

```bash
# Clone the repository
git clone https://github.com/your-username/flutter-canvas.git

# Navigate to the project directory
cd flutter-canvas

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📁 Folder Structure

The project is organized into the following directories:

- **/lib**: Contains the core source code of the application.
  - **/components**: Reusable UI components.
  - **/constants**: Application-wide constants, such as colors and styles.
  - **/helper**: Utility functions and helper classes.
  - **/providers**: State management providers.
  - **/themes**: Application themes and styling.
  - **/views**: Different screens of the application.
- **/assets**: Static assets, such as images and fonts.
- **/test**: Unit and widget tests.

## ✨ Features

- **Customizable Widgets**: A collection of widgets that can be easily customized to fit your needs.
- **Theme Support**: Seamlessly switch between light and dark themes.
- **Interactive UI**: Engaging user interfaces with smooth animations.
- **State Management**: Efficient state management using the Provider package.
- **Scalable Architecture**: A well-organized project structure that is easy to maintain and scale.

## 🎨 Components

This project includes a variety of custom components, each designed to showcase different aspects of the Flutter canvas API:

- **`ArcProgressBar`**: A circular progress bar with customizable colors and animations.
- **`ChargeLeftArc`**: A unique arc-based widget to display charging status.
- **`OddoMeterArc`**: A visually appealing odometer-style arc for displaying numerical values.
- **`RangeModeArc`**: A multi-purpose arc that can represent different modes or ranges.

### Usage Example

Here's an example of how to use the `ArcProgressBar` component:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_canvas/views/customized_widget/arc_progress_bar/arc_progress_bar.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Arc Progress Bar')),
      body: Center(
        child: ArcProgressBar(
          value: 0.75,
          strokeWidth: 10.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
```

## 🤝 Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
