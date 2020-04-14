
import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/ui/charts/daily_cases_timeline_chart.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DailyCasesChartCard extends StatelessWidget {
  final List<TimelineItem> timeline;

  DailyCasesChartCard({this.timeline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: defaultGradientDecoration,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text("New cases daily", style: TextStyle(fontFamily: "Baloo", fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600)),
          SizedBox(height: 20),
          Container(
            height: 300,
            child: DailyCasesTimeline(timeline, animate: true)
          )
        ],
      )
    );
  }
}