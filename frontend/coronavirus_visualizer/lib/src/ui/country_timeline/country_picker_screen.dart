

import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/bloc.dart';
import 'package:coronavirus_visualizer/src/bloc/timeline_bloc/timeline_event.dart';
import 'package:coronavirus_visualizer/src/services/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryPickerScreen extends StatelessWidget {
  final countries = CountriesService.instance.countries;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick country", style: TextStyle(fontFamily: "Baloo", fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
                0.1,
                0.4,
                0.6,
                0.9
              ],
            colors: [
              Color(0xFF000000),
              Color(0xFF090909),
              Color(0xFF131313),
              Color(0xFF1A1A1A)
            ]
          )
        ),
        child: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, idx) {
            return ListTile(
              title: Row(
                children: <Widget>[
                  Text(countries[idx].name, style: TextStyle(fontFamily: "Baloo", fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500)),
                  SizedBox(width: 6),
                  Text(_countryEmoji(countries[idx].code), style: TextStyle(fontSize: 20))
                ],
              ),
              onTap: () {
                BlocProvider.of<TimelineBloc>(context).add(TimelineFetchCountryTimeline(countryCode: countries[idx].code));
                Navigator.of(context).pushReplacementNamed('/country-timeline');
              },
            );
          },
        ),
      )
    );
  }

  String _countryEmoji(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }

}