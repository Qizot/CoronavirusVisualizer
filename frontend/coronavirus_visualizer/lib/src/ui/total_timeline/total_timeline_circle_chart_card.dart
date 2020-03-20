

import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/ui/charts/total_timeline_chart.dart';
import 'package:coronavirus_visualizer/src/ui/charts/total_timeline_circle_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TotalTimelineCircleChartCard extends StatelessWidget {
  final List<TimelineItem> timeline;

  TotalTimelineCircleChartCard({this.timeline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF353535), // yellow sun
            const Color(0xFF111111), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: Offset(
              10,
              10
            )
          )
        ]
      ),
      height: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(height: 200, child: TotalTimelineCircleChart(timeline, animate: true)),
          SizedBox(height: 10),
          TotalTimelineLegend()
        ],
      )
    );
  }

}