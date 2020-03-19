



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountryTimelineScreen extends StatefulWidget {

  State<CountryTimelineScreen> createState() => _CountryTimelineScreenState();

}

class _CountryTimelineScreenState extends State<CountryTimelineScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(child: Text("TO BE DONE"))
    );
  }

}