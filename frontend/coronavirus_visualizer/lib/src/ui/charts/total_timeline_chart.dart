import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/ui/charts/total_timeline_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TotalTimelineChart extends StatelessWidget {


  final List<charts.Series> seriesList;
  final bool animate;

  TotalTimelineChart(List<TimelineItem> timelineItems, {this.animate}): seriesList = generateTimeSeries(timelineItems);

  static List<charts.Series<TimelineItem, DateTime>> generateTimeSeries(List<TimelineItem> timelineItems) {
    return [
      charts.Series<TimelineItem, DateTime>(
        id: 'Total Cases',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimelineItem item, _) => item.date,
        measureFn: (TimelineItem item, _) => item.totalCases,
        data: timelineItems,
      ),
      charts.Series<TimelineItem, DateTime>(
        id: 'Total Deaths',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimelineItem item, _) => item.date,
        measureFn: (TimelineItem item, _) => item.totalDeaths,
        data: timelineItems,
      ),
      charts.Series<TimelineItem, DateTime>(
        id: 'Total Recovered',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimelineItem item, _) => item.date,
        measureFn: (TimelineItem item, _) => item.totalRecovered,
        data: timelineItems
      )
    ];
  }

  _onSelectionChanged(BuildContext context) {
    return (charts.SelectionModel<DateTime> model) {
      final selectedDatum = model.selectedDatum;

      if (selectedDatum.isNotEmpty) {
        final item = model.selectedDatum.first.datum as TimelineItem;
        showDialog(context: context, builder: (context) {
          return TotalTimelineDetailsDialog(timelineItem: item);
        });

      }
    };
  }


  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(),
      customSeriesRenderers: [
        charts.PointRendererConfig(
            customRendererId: 'customPoint')
      ],
      selectionModels: [
        charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged(context),
        )
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class TotalTimelineLegend extends StatelessWidget {
  final _fontStyle = TextStyle(fontWeight: FontWeight.w600, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.blue,
              ),
              height: 5,
              width: 15
            ),
            SizedBox(width: 5),
            Text("Total Cases", style: _fontStyle)
          ],
        ),
        SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.red,
              ),
              height: 5,
              width: 15
            ),
            SizedBox(width: 5),
            Text("Total Deaths", style: _fontStyle)
          ],
        ),
        SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.green,
              ),
              height: 5,
              width: 15
            ),
            SizedBox(width: 5),
            Text("Total Recovered", style: _fontStyle)
          ],
        ),
      ],
    );
  }
}