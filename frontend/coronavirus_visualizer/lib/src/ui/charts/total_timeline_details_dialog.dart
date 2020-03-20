




import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';


class TotalTimelineDetailsDialog extends StatelessWidget {
  final TimelineItem timelineItem;

  TotalTimelineDetailsDialog({@required this.timelineItem});
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              DateFormat("dd-MM-yyyy").format(timelineItem.date), 
              style: TextStyle(fontFamily: "Baloo", fontSize: 25, fontWeight: FontWeight.w600), 
              textAlign: TextAlign.center
            ),
            SizedBox(height: 10),
            _stat("Total cases", timelineItem.totalCases),
            SizedBox(height: 5),
            _stat("Total deaths", timelineItem.totalDeaths),
            SizedBox(height: 5),
            _stat("Total recovered", timelineItem.totalRecovered),
            SizedBox(height: 5),
            _stat("New cases", timelineItem.newCases),
            SizedBox(height: 5),
            _stat("New deaths", timelineItem.newDeaths),
            SizedBox(height: 5),

          ],
        )
      ),
    );
  }

  Widget _stat(String title, int amount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title + ":", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        SizedBox(width: 10),
        Text(amount.toString())
      ],
    );
  }
}
