class TimelineItem {
  DateTime date;
  int newCases;
  int newDeaths;
  int totalCases;
  int totalDeaths;
  int totalRecovered;

  TimelineItem(
      {this.date,
      this.newCases,
      this.newDeaths,
      this.totalCases,
      this.totalDeaths,
      this.totalRecovered});

  TimelineItem.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    newCases = json['new_cases'];
    newDeaths = json['new_deaths'];
    totalCases = json['total_cases'];
    totalDeaths = json['total_deaths'];
    totalRecovered = json['total_recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date.toIso8601String();
    data['new_cases'] = this.newCases;
    data['new_deaths'] = this.newDeaths;
    data['total_cases'] = this.totalCases;
    data['total_deaths'] = this.totalDeaths;
    data['total_recovered'] = this.totalRecovered;
    return data;
  }
}