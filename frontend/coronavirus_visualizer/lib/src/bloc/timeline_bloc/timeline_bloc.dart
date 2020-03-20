

import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/resources/timeline_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineRepository _repository = TimelineRepository();

  @override
  TimelineState get initialState => TimelineUninitialized();

  @override
  Stream<TimelineState> mapEventToState(TimelineEvent event) async* {
    if (event is TimelineInitialize) {
      yield TimelineLoading();
      await Future.delayed(Duration(seconds: 3));
      yield TimelineInitialized();
    }
    if (event is TimelineFetchTimeline) {
      yield TimelineLoading();
      await Future.delayed(Duration(seconds: 3));
      final globalTimeline = await _repository.getGlobalTimeline();
      yield TimelineFetchedGlobalTimeline(globalTimeline: globalTimeline);
    }
    if (event is TimelineFetchCountryTimeline) {
      yield TimelineLoading();
      await Future.delayed(Duration(seconds: 3));
      final countryTimeline = await _repository.getCountryTimeline(event.countryCode);
      yield TimelineFetchedCountryTimeline(countryTimeline: countryTimeline);
    }
  }


}