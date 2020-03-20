

import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PickTimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1b1a1a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _pickTimeline(title: "Global timeline", imageName: "assets/globe.png", onTap: () {
              BlocProvider.of<TimelineBloc>(context).add(TimelineFetchTimeline());
              Navigator.of(context).pushNamed("/global-timeline");
            }),
            SizedBox(height: 15),
            _pickTimeline(title: "Countries timelines", imageName: "assets/flags.png", onTap: () {
              Navigator.of(context).pushNamed("/country-picker");
            }),

          ],
        )
      ),
    );
  }

  Widget _pickTimeline({String title, String imageName, void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: 250,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.7,
            colors: [
              const Color(0xFF000000),
              const Color(0xFF171717),
            ],
            stops: [0.4, 1.0],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 20,
              spreadRadius: 5.0,
              offset: Offset(
                10,
                10
              )
            )
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(imageName, width: 150, height: 150),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontFamily: "Baloo", fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center)
          ],
        )
      ),
    );
  }
}