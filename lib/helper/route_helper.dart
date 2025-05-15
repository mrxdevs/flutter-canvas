import 'package:flutter/material.dart';

import 'package:flutter_canvas/views/home_screen/home_screen.dart';

import '../views/common_widget/container/container_screen.dart';

class RouteHelper {
  static const String homeScreen = "/home_screen";
  static const String containerScreen = "/container_screen";
  static const String canvasScreen = "/canvas_screen";

  static Map<String, Widget Function(BuildContext)> routes = {
    homeScreen: (context) => const HomeScreen(),
    containerScreen: (context) => const ContainerScreen(),
  };
}
