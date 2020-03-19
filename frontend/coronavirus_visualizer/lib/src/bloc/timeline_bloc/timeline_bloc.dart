

import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {

  @override
  TimelineState get initialState => TimelineUninitialized();

  @override
  Stream<TimelineState> mapEventToState(TimelineEvent event) async* {
    
  }


}