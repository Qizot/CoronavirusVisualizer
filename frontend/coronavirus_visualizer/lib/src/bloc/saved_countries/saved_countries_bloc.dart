import 'dart:async';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:localstorage/localstorage.dart';
import 'package:bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/bloc/saved_countries/bloc.dart';

class SavedCountriesBloc extends Bloc<SavedCountriesEvent, SavedCountriesState> {

  final _storage = LocalStorage('coronavirus');
  int _fetched = 0;
  int _errors = 0;
  int _successes = 0;


  @override
  SavedCountriesState get initialState => SavedCountriesUninitialized();

  @override
  Stream<SavedCountriesState> mapEventToState(SavedCountriesEvent event) async* {
    if (event is SavedCountriesAddCountry) {
      yield* _mapAddCountry(event);
    }
    if (event is SavedCountriesRemoveCountry) {
      yield* _mapRemoveCountry(event);
    }
    if (event is SavedCountriesFetch) {
      yield* _mapFetch(event);
    }
  }

  List<Country> _getCountries() {
    return (_storage.getItem('countries') as List)
      ?.map((country) => Country.fromJson(country))
      ?.toList() ?? [];
  }

  Stream<SavedCountriesState> _mapAddCountry(SavedCountriesAddCountry event) async* {
    try {
      final countries = _getCountries();
      
      if (countries.indexOf(event.country, 0) != -1) {
        _errors += 1;
        yield SavedCountriesError(error: "Country has already been saved!", version: _errors);
      } else {
        countries.add(event.country);
        await _storage.setItem('countries', 
          countries
          .map((c) => c.toJson())
          .toList()
        );
        _successes += 1;
        yield SavedCountriesSuccess(message: "Country has been saved!", version: _successes);
        add(SavedCountriesFetch());
      }
    } catch (error) {
      _errors += 1;
      yield SavedCountriesError(error: "Failed to save country!", version: _errors);
    }
  }

  Stream<SavedCountriesState> _mapRemoveCountry(SavedCountriesRemoveCountry event) async* {
    try {
      final countries = _getCountries();
      
      if (countries.indexOf(event.country, 0) == -1) {

        _errors += 1;
        yield SavedCountriesError(error: "Country was not previously saved!", version: _errors);
      } else {
        countries.remove(event.country);
        _storage.setItem('countries', countries.map((c) => c.toJson()).toList());

        _successes += 1;
        yield SavedCountriesSuccess(message: "Country has been removed!", version: _successes);
        add(SavedCountriesFetch());
      }

    } catch (error) {

      _errors += 1;
      yield SavedCountriesError(error: "Failed to remove country!", version: _errors);
    }
  }

  Stream<SavedCountriesState> _mapFetch(SavedCountriesFetch event) async* {
    try {
      final countries = _getCountries();

      _fetched += 1;
      yield SavedCountriesFetched(countries: countries, version: _fetched);
    } catch (error) {

      _errors += 1;
      yield SavedCountriesError(error: "Failed to fetch saved countries!", version: _errors);
    }
  }
}
