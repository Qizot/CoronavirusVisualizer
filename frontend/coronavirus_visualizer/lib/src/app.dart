

import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline_screen.dart';
import 'package:coronavirus_visualizer/src/ui/global_timeline_sceen.dart';
import 'package:coronavirus_visualizer/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {


  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimelineBloc>(
      create: (context) => TimelineBloc()
        ..add(TimelineInitialize()),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
        ),
        routes: {
          "/": (context) => SplashScreen(),
          "/global-timeline": (context)=> GlobalTimelineScreen(),
          "country-timeline": (context) => CountryTimelineScreen(),
        },
        initialRoute: "/",
      ),
    );
  }
}
