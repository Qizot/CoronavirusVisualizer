import 'package:equatable/equatable.dart';

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