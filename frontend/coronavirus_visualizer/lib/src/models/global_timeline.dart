import 'package:coronavirus_visualizer/src/models/timeline_item.dart';

class GlobalTimeline {

  List<TimelineItem> timeline;

  GlobalTimeline({this.timeline});

  GlobalTimeline.fromJson(List<dynamic> json) {

    if (json != null) {
      timeline = new List<TimelineItem>();
      json.forEach((v) {
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
