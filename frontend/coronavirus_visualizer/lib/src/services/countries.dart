

import 'package:meta/meta.dart';

class Country {
  final String name;
  final String code;
  Country({@required this.name, @required this.code});
}

class CountriesService {

  static CountriesService _instance;

  final List<Country> _countries;
  final Map<String, Country> mapped;

factory CountriesService(){
    if (CountriesService._instance == null) {
      
      Map<String, String> raw = {
        "Albania": "AL",
        "Austria": "AT",
        "Belarus": "BY",
        "Belgium": "BE",
        "Bosnia and Herzegovina": "BA",
        "Bulgaria": "BG",
        "Burkina Faso": "BF",
        "Costa Rica": "CR",
        "Croatia": "HR",
        "Cyprus": "CY",
        "Czech Republic": "CZ",
        "Denmark": "DK",
        "Egypt": "EG",
        "Estonia": "EE",
        "Finland": "FI",
        "France": "FR",
        "Germany": "DE",
        "Greece": "GR",
        "Greenland": "GL",
        "Hungary": "HU",
        "Iceland": "IS",
        "Ireland": "IE",
        "Israel": "IL",
        "Italy": "IT",
        "Latvia": "LV",
        "Lithuania": "LT",
        "Luxembourg": "LU",
        "Macedonia": "MK",
        "Moldova": "MD",
        "Mongolia": "MN",
        "Montenegro": "ME",
        "Netherlands": "NL",
        "Norway": "NO",
        "Poland": "PL",
        "Portugal": "PT",
        "Puerto Rico": "PR",
        "Romania": "RO",
        "Russia": "RU",
        "Serbia": "RS",
        "Slovakia": "SK",
        "Slovenia": "SI",
        "Spain": "ES",
        "Swaziland": "SZ",
        "Sweden": "SE",
        "Switzerland": "CH",
        "Turkey": "TR",
        "United Kingdom": "GB",
        "Ukraine": "UA"
      };

      List<Country> countries = List<Country>();
      Map<String, Country> mapped = Map<String, Country>();      
      for (var pair in raw.entries) {
        final country = Country(name: pair.key, code: pair.value);
        countries.add(country);
        mapped[pair.value] = country;
      }

      CountriesService._instance = CountriesService._privateConstructor(countries: countries, mapped: mapped);
    }
    return CountriesService._instance;
  }

  CountriesService._privateConstructor({List<Country> countries, this.mapped}): _countries = countries; 

  Country findByCode(String countryCode) {
    return mapped[countryCode];
  }


  static CountriesService get instance => _instance;

  List<Country> get countries => _countries;
  List<String> get getCountryNames => _countries.map((v) => v.name).toList();

}