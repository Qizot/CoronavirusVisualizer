

import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TotalTimelineCircleChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  TotalTimelineCircleChart(List<TimelineItem> timelineItems, {this.animate}): seriesList = generateSeries(timelineItems);


  static List<charts.Series> generateSeries(List<TimelineItem> timelineItems) {
    timelineItems.sort((a, b) => b.date.compareTo(a.date));
    final latestTimelineItem = timelineItems.first;

    final data = [
      TimelineSummary(title: "Total Cases", color: charts.MaterialPalette.blue.shadeDefault, amount: latestTimelineItem.totalCases),
      TimelineSummary(title: "Total Deaths", color: charts.MaterialPalette.red.shadeDefault, amount: latestTimelineItem.totalDeaths),
      TimelineSummary(title: "Total Recovered", color: charts.MaterialPalette.green.shadeDefault, amount: latestTimelineItem.totalRecovered),

    ];

    return [
      new charts.Series<TimelineSummary, int>(
        id: 'Sales',
        colorFn: (TimelineSummary summary, _) => summary.color,
        domainFn: (TimelineSummary summary, idx) => idx,
        measureFn: (TimelineSummary summary, _) => summary.amount,
        data: data,
      )
    ];
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }
}

class TimelineSummary {
  final String title;
  final charts.Color color;
  final int amount;
  TimelineSummary({this.title, this.color, this.amount});
}