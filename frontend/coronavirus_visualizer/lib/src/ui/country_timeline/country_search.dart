

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountrySearch extends StatefulWidget {

  final void Function(String) onChange;

  CountrySearch({this.onChange});

  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {

  TextEditingController _searchText;

  @override
  void initState() {
    super.initState();
    _searchText = TextEditingController()
      ..addListener(() => 
        widget.onChange(_searchText.text));
  }


  @override
  void dispose() {
    _searchText?.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _searchText.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: 
        TextField(
          controller: _searchText,
          decoration: InputDecoration(
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
            hintText: "Search for county...",
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, size: 20),
              color: Colors.white,
              onPressed: _reset,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))
            )
          )
        ),
    );
  }
  
}