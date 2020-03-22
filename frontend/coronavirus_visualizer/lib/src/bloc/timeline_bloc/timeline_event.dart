import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object> get props => [];
}

class TimelineInitialize extends TimelineEvent {
  @override
  String toString() => 'TimelineInitialize { }';
}

class TimelineFetchTimeline extends TimelineEvent {
  final DateTime dateFrom;
  final DateTime dateTo;

  TimelineFetchTimeline({this.dateFrom, this.dateTo});

  @override
  List<Object> get props => [dateFrom, dateTo];

  @override
  String toString() => 'TimelineFetchTimeline { dateFrom: $dateFrom, dateTo: $dateTo }';
}

class TimelineFetchCountryTimeline extends TimelineEvent {
  final String countryCode;
  final DateTime dateFrom;
  final DateTime dateTo;

  TimelineFetchCountryTimeline({@required this.countryCode, this.dateFrom, this.dateTo});

  @override
  List<Object> get props => [countryCode, dateFrom, dateTo];

  @override
  String toString() => 'TimelineFetchCountryTimeline { countryCode: $countryCode, dateFrom: $dateFrom, dateTo: $dateTo }';
}
