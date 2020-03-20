



import 'package:coronavirus_visualizer/src/ui/splash/animated_virus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatelessWidget {
  final String title;

  LoadingScreen({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          // center: const Alignment(0.7, -0.6), // near the top right
          radius: 0.7,
          colors: [
            const Color(0xFF353535), // yellow sun
            const Color(0xFF111111), // blue sky
          ],
          stops: [0.4, 1.0],
        )
      ),
      child: Stack(
        children: <Widget>[
          AnimatedVirus(),
          Positioned(
            bottom: 120,
            left: 60,
            right: 60,
            child: Text(title, style: TextStyle(fontFamily: "Baloo", color: Colors.white, fontSize: 25), textAlign: TextAlign.center,)
          )
        ],
      )
    );
  }
}