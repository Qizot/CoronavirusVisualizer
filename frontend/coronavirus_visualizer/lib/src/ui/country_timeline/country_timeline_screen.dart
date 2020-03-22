



import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/ui/splash/error_screen.dart';
import 'package:coronavirus_visualizer/src/ui/splash/loading_screen.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/total_timeline_chart_card.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/total_timeline_circle_chart_card.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/total_timeline_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryTimelineScreen extends StatefulWidget {

  State<CountryTimelineScreen> createState() => _CountryTimelineScreenState();

}

class _CountryTimelineScreenState extends State<CountryTimelineScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String appTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appTitle != null ?
      AppBar(
        title: Text(appTitle, style: TextStyle(fontFamily: "Baloo", fontSize: 25)),
        centerTitle: true,
      ) : null,
      body: BlocConsumer<TimelineBloc, TimelineState>(
        listener: (context, state) {
          if (state is TimelineFetchedCountryTimeline) {
            setState(() {
              appTitle = state.countryTimeline.country;
            });
          }
        },
        builder: (context, state) {
            if (state is TimelineLoading) {
              return LoadingScreen(title: "Loading timeline...");
            }
            if (state is TimelineError) {
              return ErrorScreen(error: state.error);
            }
            if (state is TimelineFetchedCountryTimeline) {
              return ListView(
                children: <Widget>[
                  TotalTimelineChartCard(timeline: state.countryTimeline.timeline),
                  SizedBox(height: 15),
                  TotalTimelineCircleChartCard(timeline: state.countryTimeline.timeline),
                  SizedBox(height: 15),
                  TotalTimelineStats(timeline: state.countryTimeline.timeline)
                ],
              );
            }
            return Center(child: Text("Nothing"));
          }
      )
    );
  }

}