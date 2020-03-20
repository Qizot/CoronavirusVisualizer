import 'package:coronavirus_visualizer/src/app.dart';
import 'package:coronavirus_visualizer/src/bloc/bloc_delegate.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    CountriesService();
    runApp(App());
}

