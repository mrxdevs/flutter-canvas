import 'package:flutter/material.dart';
import 'package:flutter_canvas/views/customized_widget/arc_progress_bar/arc_progress_bar_studio.dart';
import 'package:flutter_canvas/views/customized_widget/charge_left_arc/charge_left_arc_studio.dart';
import 'package:flutter_canvas/views/customized_widget/oddo_meter_arc/oddo_meter_studio.dart';
import 'package:flutter_canvas/views/customized_widget/range_mode_arc/range_mode_arc_studio.dart';
import 'package:flutter_canvas/views/customized_widget/two_side_arc_gauge/two_side_arc_gauge_studio.dart';
import 'package:flutter_canvas/views/customized_widget/tyre_pressure_arc/tyre_pressure_arc_studio.dart';

import 'package:flutter_canvas/views/home_screen/home_screen.dart';

import '../views/common_widget/container/container_screen.dart';

class RouteHelper {
  static const String homeScreen = "/home_screen";
  static const String containerScreen = "/container_screen";
  static const String canvasScreen = "/canvas_screen";
  static const String towSideArcGaugeStudioScreen =
      "/two_side_arc_gauge_studio_screen";
  static const String arcProgressBarStudioScreen = "/arc_progress_bar_screen";
  static const String chargeLeftArcStudio = "/charge_left_arc_studio";
  static const String tyrePressureArcStudio = "/tyre_pressure_arc_studio";
  static const String rangeModeArcStudio = "/rangeModeArcStudio";
  static const String oddoArcStudio = "/oddoArcStudio";

  static Map<String, Widget Function(BuildContext)> routes = {
    homeScreen: (context) => const HomeScreen(),
    containerScreen: (context) => const ContainerScreen(),
    towSideArcGaugeStudioScreen: (context) => const TwoSideArcGaugeStudio(),
    arcProgressBarStudioScreen: (context) => const ArcProgressBarStudio(),
    chargeLeftArcStudio: (context) => const ChargeLeftArcStudio(),
    oddoArcStudio: (context) => const OddoMeterArcStudio(),
    tyrePressureArcStudio: (context) => const TyrePressureArcStudio(),
    rangeModeArcStudio: (context) => const RangeModeArcStudio(),
  };
}
