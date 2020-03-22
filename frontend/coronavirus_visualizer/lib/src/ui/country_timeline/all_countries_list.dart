

import 'package:coronavirus_visualizer/src/bloc/saved_countries/bloc.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/country_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AllCountriesList extends StatelessWidget {
  final countries = CountriesService.instance.countries;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, idx) {
          return CountrySlidable(
            country: countries[idx],
            action: IconSlideAction(
              caption: "Save",
              color: Colors.green,
              icon: Icons.save,
              onTap: () => BlocProvider.of<SavedCountriesBloc>(context)
                .add(SavedCountriesAddCountry(country: countries[idx]))
            ) 
          );
        },
      ),
    );
  }
}