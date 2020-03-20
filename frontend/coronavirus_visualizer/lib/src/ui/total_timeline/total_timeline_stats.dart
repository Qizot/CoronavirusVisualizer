

import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
          Text("Most recent statistics", style: GoogleFonts.baloo(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600)),
          SizedBox(height: 15),
          GridView.count(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: <Widget>[
              _info("Total cases", timeline.first.totalCases),
              _info("New cases", timeline.first.newCases),
              _info("Total deaths", timeline.first.totalDeaths),
              _info("New deaths", timeline.first.newDeaths),
              _info("Total recovered", timeline.first.totalRecovered),

            ],
          )
        ],
      )
    );
  }

  Widget _info(String text, int amount) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text, style: GoogleFonts.baloo(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
          SizedBox(height: 10),
          Text(amount.toString(), style:GoogleFonts.baloo(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w700))
        ],
      ),
    );
  }

}