


import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/models/global_timeline.dart';
import 'package:coronavirus_visualizer/src/ui/splash/error_screen.dart';
import 'package:coronavirus_visualizer/src/ui/splash/loading_screen.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/total_timeline_chart_card.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/total_timeline_circle_chart_card.dart';
import 'package:coronavirus_visualizer/src/ui/total_timeline/total_timeline_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalTimelineScreen extends StatefulWidget {

  State<GlobalTimelineScreen> createState() => _GlobalTimelineScreenState();

}

class _GlobalTimelineScreenState extends State<GlobalTimelineScreen> {

  String appTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appTitle != null ? AppBar(
        title: Text(appTitle, style: TextStyle(fontFamily: "Baloo", fontSize: 20)),
        centerTitle: true,
      ): null,
      body: BlocListener<TimelineBloc, TimelineState>(
        listener: (context, state) {
          if (state is TimelineFetchedGlobalTimeline) {
            setState(() {
              appTitle = "Global timeline";
            });
          }
        },
        child: BlocBuilder<TimelineBloc, TimelineState>(
          builder: (context, state) {
            if (state is TimelineLoading) {
              return LoadingScreen(title: "Loading global timeline...");
            }
            if (state is TimelineFetchedGlobalTimeline) {
              return _totalTimeline(state.globalTimeline);
            }
            if (state is TimelineError) {
              return ErrorScreen(error: state.error);
            }
            return Container();
          }
        ),
      )
    );
  }

  Widget _totalTimeline(GlobalTimeline globalTimeline) {
    return ListView(
      children: <Widget>[
        TotalTimelineChartCard(timeline: globalTimeline.timeline),
        SizedBox(height: 15),
        TotalTimelineCircleChartCard(timeline: globalTimeline.timeline),
        SizedBox(height: 15),
        TotalTimelineStats(timeline: globalTimeline.timeline)
      ],
    );
  }

}