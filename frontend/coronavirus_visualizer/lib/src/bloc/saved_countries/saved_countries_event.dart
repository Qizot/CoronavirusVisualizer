import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class SavedCountriesEvent extends Equatable {
  const SavedCountriesEvent();

  @override
  List<Object> get props => [];
}

class SavedCountriesAddCountry extends SavedCountriesEvent {
  final Country country;

  SavedCountriesAddCountry({@required this.country});

  @override
  List<Object> get props => [country];

  @override
  String toString() {
    return 'SavedCountriesAddCountry { country: $country }';
  }
}

class SavedCountriesRemoveCountry extends SavedCountriesEvent {
    final Country country;

  SavedCountriesRemoveCountry({@required this.country});

  @override
  List<Object> get props => [country];

  @override
  String toString() {
    return 'SavedCountriesRemoveCountry { country: $country }';
  }
}

class SavedCountriesFetch extends SavedCountriesEvent {
  @override
  String toString() {
    return 'SavedCountriesFetch { }';
  }
}

