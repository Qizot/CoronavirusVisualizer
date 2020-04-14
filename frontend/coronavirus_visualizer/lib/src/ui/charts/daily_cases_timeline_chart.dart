import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/ui/charts/total_timeline_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DailyCasesTimeline extends StatelessWidget {


  final List<charts.Series> seriesList;
  final bool animate;

  DailyCasesTimeline(List<TimelineItem> timelineItems, {this.animate}): seriesList = generateTimeSeries(timelineItems);

  static List<charts.Series<TimelineItem, DateTime>> generateTimeSeries(List<TimelineItem> timelineItems) {
    return [
      charts.Series<TimelineItem, DateTime>(
        id: 'Daily Cases',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimelineItem item, _) => item.date,
        measureFn: (TimelineItem item, _) => item.newCases,
        data: timelineItems,
      ),
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