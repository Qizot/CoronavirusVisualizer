

import 'package:coronavirus_visualizer/src/bloc/saved_countries/bloc.dart';
import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/country_picker_screen.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/country_timeline_screen.dart';
import 'package:coronavirus_visualizer/src/ui/gloabl_timeline/global_timeline_sceen.dart';
import 'package:coronavirus_visualizer/src/ui/pick_timeline/pick_timeline_screen.dart';
import 'package:coronavirus_visualizer/src/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {


  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimelineBloc>(
          create: (context) => TimelineBloc()
            ..add(TimelineInitialize()),
        ),
        BlocProvider<SavedCountriesBloc>(
          create: (context) => SavedCountriesBloc()
            ..add(SavedCountriesFetch()),
        )
      ],
      child:MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
        ),
        routes: {
          "/": (context) => SplashScreen(),
          "/global-timeline": (context)=> GlobalTimelineScreen(),
          "/country-timeline": (context) => CountryTimelineScreen(),
          "/country-picker": (context) => CountryPickerScreen(),
          "/timeline-picker": (context) => PickTimelineScreen(),
        },
        initialRoute: "/",
      ),
    );
  }
}
