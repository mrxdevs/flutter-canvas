import 'package:flutter/material.dart';
import 'package:flutter_canvas/helper/route_helper.dart';
import 'package:flutter_canvas/views/customized_widget/two_side_arc_gauge/two_side_arc_gauge_screen.dart';
import 'package:flutter_canvas/views/home_screen/components/widget_card.dart';

class CustomizedWidgetSection extends StatelessWidget {
  const CustomizedWidgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customized Widgets',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Change this
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select a custom widget to customized and explore',
          style: TextStyle(color: Color(0xFFB8B8D2)),
        ),
        const SizedBox(height: 24),
        SizedBox(
          child: GridView.count(
            // scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            crossAxisCount: MediaQuery.sizeOf(context).width ~/ 180,
            childAspectRatio: 1.0,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              WidgetCard(
                title: "Arc Gauge",
                icon: Icons.generating_tokens_outlined,
                iconColor: Colors.teal,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteHelper.towSideArcGaugeStudioScreen,
                ),
                displayWidget: const TyrePressureAnimationWidget(
                    rearTyrePressure: 20,
                    frontTyrePressure: 30,
                    bgColor: Colors.white,
                    sideBgColor: Colors.white),
              ),
              WidgetCard(
                title: "Arc Progress",
                icon: Icons.architecture_outlined,
                iconColor: Colors.redAccent,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteHelper.arcProgressBarStudioScreen,
                ),
                displayWidget: const TyrePressureAnimationWidget(
                    rearTyrePressure: 20,
                    frontTyrePressure: 30,
                    bgColor: Colors.white,
                    sideBgColor: Colors.white),
              ),
              WidgetCard(
                title: "Charge Left",
                icon: Icons.architecture_outlined,
                iconColor: Colors.redAccent,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteHelper.arcProgressBarStudioScreen,
                ),
                displayWidget: const TyrePressureAnimationWidget(
                    rearTyrePressure: 20,
                    frontTyrePressure: 30,
                    bgColor: Colors.white,
                    sideBgColor: Colors.white),
              ),
              WidgetCard(
                title: "Tyre Pressure",
                icon: Icons.architecture_outlined,
                iconColor: Colors.redAccent,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteHelper.arcProgressBarStudioScreen,
                ),
                displayWidget: const TyrePressureAnimationWidget(
                    rearTyrePressure: 20,
                    frontTyrePressure: 30,
                    bgColor: Colors.white,
                    sideBgColor: Colors.white),
              ),
              WidgetCard(
                title: "Renge Mode Arc",
                icon: Icons.architecture_outlined,
                iconColor: Colors.redAccent,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteHelper.arcProgressBarStudioScreen,
                ),
                displayWidget: const TyrePressureAnimationWidget(
                    rearTyrePressure: 20,
                    frontTyrePressure: 30,
                    bgColor: Colors.white,
                    sideBgColor: Colors.white),
              ),
              WidgetCard(
                title: "Oddo Meter",
                icon: Icons.architecture_outlined,
                iconColor: Colors.redAccent,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteHelper.arcProgressBarStudioScreen,
                ),
                displayWidget: const TyrePressureAnimationWidget(
                    rearTyrePressure: 20,
                    frontTyrePressure: 30,
                    bgColor: Colors.white,
                    sideBgColor: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
