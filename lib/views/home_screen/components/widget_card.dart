 import 'package:flutter/material.dart';

 class WidgetCard extends StatelessWidget{
  final String title;
   final IconData icon;
   final Color color;
   final VoidCallback onTap;

    const WidgetCard({required this.title, required this.icon, required this.color, required this.onTap , super.key});
    
   

 
@override
Widget build(BuildContext context){
   

    return SizedBox(
      height: 150,
      width: 120,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: const Color(0xFF2D2D44),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 40, color: color),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 }