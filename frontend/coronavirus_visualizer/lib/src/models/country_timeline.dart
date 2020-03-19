import 'package:coronavirus_visualizer/models/timeline_item.dart';

class CountryTimeline {
  String country;
  String code;
  List<TimelineItem> timeline;

  CountryTimeline({this.country, this.code, this.timeline});

  CountryTimeline.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    code = json['code'];
    if (json['timeline'] != null) {
      timeline = new List<TimelineItem>();
      json['timeline'].forEach((v) {
        timeline.add(new TimelineItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['code'] = this.code;
    if (this.timeline != null) {
      data['timeline'] = this.timeline.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
