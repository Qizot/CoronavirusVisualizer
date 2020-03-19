


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalTimelineScreen extends StatefulWidget {

  State<GlobalTimelineScreen> createState() => _GlobalTimelineScreenState();

}

class _GlobalTimelineScreenState extends State<GlobalTimelineScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(child: Text("TO BE DONE"))
    );
  }

}