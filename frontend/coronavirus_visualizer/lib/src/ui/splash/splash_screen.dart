import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/ui/splash/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener<TimelineBloc, TimelineState>(
        listener: (context, state) {
          if (state is TimelineInitialized) {
            Navigator.of(context).pushReplacementNamed("/timeline-picker");
          }
        },
        child: LoadingScreen(title: "Preparing virus data...")
      )

    );
  }
}