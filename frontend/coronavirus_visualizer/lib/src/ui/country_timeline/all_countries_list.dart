

import 'package:coronavirus_visualizer/src/bloc/saved_countries/bloc.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/country_search.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/country_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllCountriesList extends StatefulWidget {
  final countries = CountriesService.instance.countries;
  @override
  _AllCountriesListState createState() => _AllCountriesListState();
}

class _AllCountriesListState extends State<AllCountriesList> {

  List<Country> _filteredCountries;

  @override
  void initState() {
    _filteredCountries = widget.countries;
    super.initState();
  }


  void _filterCountries(String text) {
    setState(() {
      _filteredCountries = widget.countries
        .where(
          (value) => value.name
            .toLowerCase()
            .contains(text.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CountrySearch(onChange: _filterCountries),
         Flexible(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, idx) {
                return CountrySlidable(
                  country: _filteredCountries[idx],
                  action: IconSlideAction(
                    caption: "Save",
                    color: Colors.green,
                    icon: Icons.save,
                    onTap: () {
                      BlocProvider.of<SavedCountriesBloc>(context)
                      .add(SavedCountriesAddCountry(country: _filteredCountries[idx]));
                    }
                  ) 
                );
              },
            ),
        ),
         ),
      ]
    );
  }
}