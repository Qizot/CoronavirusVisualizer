



import 'package:coronavirus_visualizer/src/models/country_timeline.dart';
import 'package:coronavirus_visualizer/src/models/global_timeline.dart';
import 'package:coronavirus_visualizer/src/resources/timeline_provider.dart';

class TimelineRepository {
  TimelineProvider provider = MockTimelineProvider();

  Future<GlobalTimeline> getGlobalTimeline({DateTime dateFrom, DateTime dateTo}) async {
    final result = await provider.getGlobalTimeline(dateFrom: dateFrom, dateTo: dateTo);
    return result;
  }

  Future<CountryTimeline> getCountryTimeline(String countryCode, {DateTime dateFrom, DateTime dateTo}) async {
    final result = await provider.getCountryTimeline(countryCode, dateFrom: dateFrom, dateTo: dateTo);
    return result;
  }

  Future<List<CountryTimeline>> getCountryTimelineList(List<String> countryCodes, {DateTime dateFrom, DateTime dateTo}) async {
    final result = await provider.getCountryTimelineList(countryCodes, dateFrom: dateFrom, dateTo: dateTo);
    return result;
  }
}