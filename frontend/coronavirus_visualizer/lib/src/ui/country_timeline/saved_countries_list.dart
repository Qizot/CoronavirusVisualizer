

import 'package:coronavirus_visualizer/src/bloc/saved_countries/bloc.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/country_search.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/country_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SavedCountriesList extends StatefulWidget {

  @override
  State<SavedCountriesList> createState() => _SavedCountriesListState();
}

class _SavedCountriesListState extends State<SavedCountriesList> {
  String _textFilter;

  @override
  void initState() {
    _textFilter = "";
    BlocProvider.of<SavedCountriesBloc>(context).add(SavedCountriesFetch());
    super.initState();
  }


  List<Country> _filterCountries(List<Country> countries, String text) {
   return countries.where((value) => value.name.toLowerCase().contains(text.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedCountriesBloc, SavedCountriesState>(
      listener: (_, state) {
        // pass
      },
      buildWhen: (prev, curr) {
        if (prev is SavedCountriesFetched && !(curr is SavedCountriesFetched))
          return false;
        return true;
      },
      builder: (context, state) {
        List<Country> countries = [];
        if (state is SavedCountriesFetched) {
          countries = _filterCountries(state.countries, _textFilter);
        }
        return Column(
          children: <Widget>[
            CountrySearch(onChange: (value) => setState(() => _textFilter = value)),
             Flexible(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, idx) {
                    return CountrySlidable(
                      country: countries[idx],
                      action: IconSlideAction(
                        caption: "Remove",
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => BlocProvider.of<SavedCountriesBloc>(context)
                          .add(SavedCountriesRemoveCountry(country: countries[idx]))
                      ) 
                    );
                  },
                ),
            ),
             ),
          ]
        );
      }
    );
  }
}