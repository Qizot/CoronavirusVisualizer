

import 'package:coronavirus_visualizer/src/bloc/saved_countries/bloc.dart';
import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meta/meta.dart';

class CountrySlidable extends StatelessWidget {
  final Country country;
  final IconSlideAction action;

  CountrySlidable({@required this.country, this.action});


  String _countryEmoji(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        action
      ],
      child: ListTile(
        title: Row(
          children: <Widget>[
            Text(country.name, style: TextStyle(fontFamily: "Baloo", fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
            SizedBox(width: 6),
            Text(_countryEmoji(country.code), style: TextStyle(fontSize: 20))
          ],
        ),
        onTap: () {
          BlocProvider.of<TimelineBloc>(context).add(TimelineFetchCountryTimeline(countryCode: country.code));
          Navigator.of(context).pushNamed('/country-timeline');
        },
      ),
    );
  }


}