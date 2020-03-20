import 'package:coronavirus_visualizer/src/models/country_timeline.dart';
import 'package:coronavirus_visualizer/src/models/global_timeline.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object> get props => [];
}

class TimelineUninitialized extends TimelineState {
  @override
  String toString() {
    return 'TImelineUninitialized { }';
  }
}

class TimelineLoading extends TimelineState {
  @override
  String toString() {
    return 'TimelineLoading { }';
  }
}

class TimelineInitialized extends TimelineState {
  @override
  String toString() {
    return 'TimelineInitialized { }';
  }
}

class TimelineError extends TimelineState {
  final String error;

  TimelineError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'TimelineError { error: $error }';
  }
}

class TimelineFetchedGlobalTimeline extends TimelineState {
  final GlobalTimeline globalTimeline;

  TimelineFetchedGlobalTimeline({@required this.globalTimeline});

  @override
  List<Object> get props => [globalTimeline];

  @override
  String toString() {
    return 'TimelineFetchedGlobalTimeline { globalTimeline: $globalTimeline }';
  }
}

class TimelineFetchedCountryTimeline extends TimelineState {
  final CountryTimeline countryTimeline;

  TimelineFetchedCountryTimeline({@required this.countryTimeline});

  @override
  List<Object> get props => [countryTimeline];

  @override
  String toString() {
    return 'TimelineFetchedCountryTimeline { countryTimeline: $countryTimeline }';
  }

}