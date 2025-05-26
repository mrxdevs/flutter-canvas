import 'package:flutter/material.dart';
import 'package:flutter_canvas/views/customized_widget/arc_progress_bar.dart/arc_progress_bar_studio.dart';
import 'package:flutter_canvas/views/customized_widget/two_side_arc_gauge_studio.dart';

import 'package:flutter_canvas/views/home_screen/home_screen.dart';

import '../views/common_widget/container/container_screen.dart';

class RouteHelper {
  static const String homeScreen = "/home_screen";
  static const String containerScreen = "/container_screen";
  static const String canvasScreen = "/canvas_screen";
  static const String towSideArcGaugeStudioScreen =
      "/two_side_arc_gauge_studio_screen";
  static const String arcProgressBarStudioScreen = "/arc_progress_bar_screen";

  static Map<String, Widget Function(BuildContext)> routes = {
    homeScreen: (context) => const HomeScreen(),
    containerScreen: (context) => const ContainerScreen(),
    towSideArcGaugeStudioScreen: (context) => const TwoSideArcGaugeStudio(),
    arcProgressBarStudioScreen: (context) => const ArcProgressBarStudio(),
  };
}
