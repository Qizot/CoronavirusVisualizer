

import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class TotalTimelineStats extends StatelessWidget {
  final List<TimelineItem> timeline;

  TotalTimelineStats({@required this.timeline}) {
    timeline.sort((a, b) => b.date.compareTo(a.date));
  }

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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Most recent statistics", style: TextStyle(fontFamily: "Baloo", fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600)),
          SizedBox(height: 15),
          GridView.count(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            children: <Widget>[
              // new cases and new deaths are only submitted a day before
              _info("Total cases", timeline.first.totalCases ?? 0),
              _info("New cases", timeline[1].newCases ?? 0),
              _info("Total deaths", timeline.first.totalDeaths ?? 0),
              _info("New deaths", timeline[1].newDeaths ?? 0),
              _info("Total recovered", timeline.first.totalRecovered ?? 0),

            ],
          )
        ],
      )
    );
  }

  Widget _info(String text, int amount) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(text, style: TextStyle(fontFamily: "Baloo", fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
        SizedBox(height: 10),
        Text(amount.toString(), style: TextStyle(fontFamily: "Baloo", fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700))
      ],
    );
  }

}