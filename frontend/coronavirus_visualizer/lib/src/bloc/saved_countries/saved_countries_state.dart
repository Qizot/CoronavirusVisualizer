import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:equatable/equatable.dart';


abstract class SavedCountriesState extends Equatable {
  const SavedCountriesState();

  @override
  List<Object> get props => [];
}

class SavedCountriesUninitialized extends SavedCountriesState {
  @override
  String toString() => 'SavedCountriesUninitialized { }';

}

class SavedCountriesError extends SavedCountriesState {
  final String error;
  final int version;

  SavedCountriesError({this.error, this.version});

  @override
  List<Object> get props => [version, error];

  @override
  String toString() => 'SavedCountriesStateError { version: $version, error: $error }';
}

class SavedCountriesSuccess extends SavedCountriesState {
  final String message;
  final int version;

  SavedCountriesSuccess({this.message, this.version});

  @override
  List<Object> get props => [version, message];

  @override
  String toString() => 'SavedCountriesSuccess { version: $version, message: $message }';
}

class SavedCountriesLoading extends SavedCountriesState {
  @override
  String toString() => 'SavedCountriesStateLoading { }';
}

class SavedCountriesFetched extends SavedCountriesState {
  final List<Country> countries;
  final int version;

  SavedCountriesFetched({this.countries, this.version});

  @override
  List<Object> get props => [version, countries];

  @override
  String toString() => 'SavedCountriesFetched { version: $version, countries: $countries }';
}

