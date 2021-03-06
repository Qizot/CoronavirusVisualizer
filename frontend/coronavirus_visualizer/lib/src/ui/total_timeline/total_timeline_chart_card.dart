import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/ui/charts/total_timeline_chart.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/utils.dart';
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
      decoration: defaultGradientDecoration,
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
    );
  }
}