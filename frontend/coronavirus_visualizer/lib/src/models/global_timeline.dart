



import 'package:coronavirus_visualizer/models/timeline_item.dart';

class GlobalTimeline {

  List<TimelineItem> timeline;

  GlobalTimeline({this.timeline});

  GlobalTimeline.fromJson(Map<String, dynamic> json) {

    if (json['timeline'] != null) {
      timeline = new List<TimelineItem>();
      json['timeline'].forEach((v) {
        timeline.add(new TimelineItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeline != null) {
      data['timeline'] = this.timeline.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
