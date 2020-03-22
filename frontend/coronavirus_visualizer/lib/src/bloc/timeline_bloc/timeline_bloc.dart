

import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/resources/timeline_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineRepository _repository = TimelineRepository();

  @override
  TimelineState get initialState => TimelineUninitialized();

  @override
  Stream<TimelineState> mapEventToState(TimelineEvent event) async* {
    if (event is TimelineInitialize) {
      yield TimelineLoading();
      await Future.delayed(Duration(seconds: 2));
      yield TimelineInitialized();
    }
    if (event is TimelineFetchTimeline) {
      yield TimelineLoading();
      final showLoadingScreen = Future.delayed(Duration(seconds: 3));
      
      try {
        final globalTimeline = await _repository.getGlobalTimeline();
        await showLoadingScreen;
        yield TimelineFetchedGlobalTimeline(globalTimeline: globalTimeline);
      } on DioError {
        yield TimelineError(error: "Error has occured while communicating with backend!");
      } on Exception {
        yield TimelineError(error: "Unknown error has occured, try again later!");
      }
    }
    if (event is TimelineFetchCountryTimeline) {
      yield TimelineLoading();
      final showLoadingScreen = Future.delayed(Duration(seconds: 2));

      try {
        final countryTimeline = await _repository.getCountryTimeline(event.countryCode);
        await showLoadingScreen;
        yield TimelineFetchedCountryTimeline(countryTimeline: countryTimeline);
      } on DioError {
        yield TimelineError(error: "Error has occured while communicating with backend!");
      } on Exception {
        yield TimelineError(error: "Unknown error has occured, try again later!");
      }

    }
  }


}