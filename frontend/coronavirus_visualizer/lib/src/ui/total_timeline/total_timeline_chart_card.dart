

import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/ui/charts/total_timeline_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TotalTimelineChartCard extends StatelessWidget {
  final List<TimelineItem> timeline;

  TotalTimelineChartCard({this.timeline});

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
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          TotalTimelineLegend(),
          SizedBox(height: 20),
          Container(
            height: 300,
            child: TotalTimelineChart(timeline, animate: true)
          )
        ],
      )
    );;
  }
}