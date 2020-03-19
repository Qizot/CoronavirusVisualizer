


import 'dart:math';

import 'package:coronavirus_visualizer/src/models/country_timeline.dart';
import 'package:coronavirus_visualizer/src/models/global_timeline.dart';
import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:dio/dio.dart';

abstract class TimelineProvider {
  Future<GlobalTimeline> getGlobalTimeline({DateTime dateFrom, DateTime dateTo});
  Future<CountryTimeline> getCountryTimeline(String countryCode, {DateTime dateFrom, DateTime dateTo});
  Future<List<CountryTimeline>> getCountryTimelineList(List<String> countryCodes, {DateTime dateFrom, DateTime dateTo});

}


class ApiTimelineProvider extends TimelineProvider {
  final client = Dio();

  @override
  Future<GlobalTimeline> getGlobalTimeline({DateTime dateFrom, DateTime dateTo}) async {
    // TODO: implement getGlobalTimeline
    throw UnimplementedError();
  }

  @override
  Future<CountryTimeline> getCountryTimeline(String countryCode, {DateTime dateFrom, DateTime dateTo}) async {
    // TODO: implement getCountryTimeline
    throw UnimplementedError();
  }

  @override
  Future<List<CountryTimeline>> getCountryTimelineList(List<String> countryCodes, {DateTime dateFrom, DateTime dateTo}) async {
    // TODO: implement getCountryTimelineList
    throw UnimplementedError();
  }
}

class MockTimelineProvider extends TimelineProvider {

  List<TimelineItem> _generateRandomItems(DateTime startDate, int days) {
    List<TimelineItem> items = List<TimelineItem>();

    Random rand = Random();
    DateTime date = startDate;
    int newCases = 0;
    int newDeaths = 0;
    int totalCases = 0;
    int totalDeaths = 0;
    int totalRecovered = 0;

    for (int i = 0; i < days; i++) {
      date = date.add(Duration(days: 1));
      newCases += rand.nextInt(100);
      newDeaths += rand.nextInt(20);
      totalCases += newCases;
      totalDeaths += newDeaths;
      totalRecovered += rand.nextInt(15);
      items.add(TimelineItem(date: date, newCases: newCases, newDeaths: newDeaths, totalCases: totalCases, totalDeaths: totalDeaths, totalRecovered: totalRecovered));
    }
    return items;
  }

  @override
  Future<GlobalTimeline> getGlobalTimeline({DateTime dateFrom, DateTime dateTo}) async {
    DateTime date = DateTime(2020, 1, 12);
    int days = 90;
    List<TimelineItem> items = _generateRandomItems(date, days);
    return GlobalTimeline(timeline: items);
  }

  @override
  Future<CountryTimeline> getCountryTimeline(String countryCode, {DateTime dateFrom, DateTime dateTo}) async {
    final country = CountriesService.instance.findByCode(countryCode);
    DateTime date = DateTime(2020, 1, 12);
    int days = 90;
    final items = _generateRandomItems(date, days);
    return CountryTimeline(country: country.name, code: country.code, timeline: items);
  }

  @override
  Future<List<CountryTimeline>> getCountryTimelineList(List<String> countryCodes, {DateTime dateFrom, DateTime dateTo}) async {
    final countries = countryCodes.map((code) => CountriesService.instance.findByCode(code)).toList();
    final timelines = List<CountryTimeline>();
    DateTime date = DateTime(2020, 1, 12);
    int days = 90;
    for (var country in countries) {
      final items = _generateRandomItems(date, days);
      timelines.add(CountryTimeline(country: country.name, code: country.code, timeline: items));
    }
    return timelines;
  }
}