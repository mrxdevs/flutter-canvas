import 'package:flutter/material.dart';
import 'package:flutter_canvas/helper/route_helper.dart';
import 'package:flutter_canvas/views/home_screen/components/widget_card.dart';

class CommanWidgetSection extends StatelessWidget {
  const CommanWidgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Widget Playground',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Select a widget to customize and explore',
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
                title: 'Container',
                icon: Icons.crop_square_rounded,
                color: Colors.blue,
                onTap: () => Navigator.pushNamed(
                  context,
                  RouteHelper.containerScreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
