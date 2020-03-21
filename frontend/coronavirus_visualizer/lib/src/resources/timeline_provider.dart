


import 'dart:math';

import 'package:coronavirus_visualizer/src/config/api_config.dart';
import 'package:coronavirus_visualizer/src/models/country_timeline.dart';
import 'package:coronavirus_visualizer/src/models/global_timeline.dart';
import 'package:coronavirus_visualizer/src/models/timeline_item.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

abstract class TimelineProvider {
  Future<GlobalTimeline> getGlobalTimeline({DateTime dateFrom, DateTime dateTo});
  Future<CountryTimeline> getCountryTimeline(String countryCode, {DateTime dateFrom, DateTime dateTo});
  Future<List<CountryTimeline>> getCountryTimelineList(List<String> countryCodes, {DateTime dateFrom, DateTime dateTo});

}


class ApiTimelineProvider extends TimelineProvider {

  ApiTimelineProvider() {
    client.options.connectTimeout = 5000;
  }

  final client = Dio();
  final globalTimeline = "/global-timeline";
  final countryTimeline = "/timelines";

  @override
  Future<GlobalTimeline> getGlobalTimeline({DateTime dateFrom, DateTime dateTo}) async {
    final response = await client.get(ApiConfig.instance.apiUrl + globalTimeline);
    return GlobalTimeline.fromJson(response.data);
  }

  @override
  Future<CountryTimeline> getCountryTimeline(String countryCode, {DateTime dateFrom, DateTime dateTo}) async {
    String params = "?countries=$countryCode";
    String dateFormat = "yyyy-MM-dd";

    if (dateFrom != null) {
      params += "&dateFrom=${DateFormat(dateFormat).format(dateFrom)}";
    }

    if (dateTo != null) {
      params += "&dateFrom=${DateFormat(dateFormat).format(dateTo)}";
    }

    final response = await client.get(ApiConfig.instance.apiUrl + countryTimeline + params);
    if ((response.data as List).length != 1) {
      throw Exception("Expected single element list");
    }
    print("got here");
    return CountryTimeline.fromJson(response.data[0]);
  }

  @override
  Future<List<CountryTimeline>> getCountryTimelineList(List<String> countryCodes, {DateTime dateFrom, DateTime dateTo}) async {
     String params = "?countries=" + countryCodes.join(",");
    String dateFormat = "yyyy-MM-dd";

    if (dateFrom != null) {
      params += "&dateFrom=${DateFormat(dateFormat).format(dateFrom)}";
    }

    if (dateTo != null) {
      params += "&dateFrom=${DateFormat(dateFormat).format(dateTo)}";
    }

    final response = await client.get(ApiConfig.instance.apiUrl + countryTimeline + params);
    var timelines = List<CountryTimeline>();

    for (var timeline in response.data) {
      timelines.add(CountryTimeline.fromJson(timeline));
    }

    return timelines;
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
      newCases = rand.nextInt(100);
      newDeaths = rand.nextInt(20);
      totalCases += newCases;
      totalDeaths += newDeaths;
      totalRecovered += rand.nextInt(20);
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