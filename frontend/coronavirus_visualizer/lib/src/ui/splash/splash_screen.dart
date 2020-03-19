import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/ui/splash/loading_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocBuilder<TimelineBloc, TimelineState>(
        builder: (context, state) {

          if (state is TimelineLoading) {
            return LoadingScreen();
          }
          return Center(child: Text("To be done soon"));
        }
      )

    );
  }
}