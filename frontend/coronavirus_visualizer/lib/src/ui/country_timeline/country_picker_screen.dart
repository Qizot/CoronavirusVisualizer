import 'package:coronavirus_visualizer/src/bloc/saved_countries/bloc.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/all_countries_list.dart';
import 'package:coronavirus_visualizer/src/ui/country_timeline/saved_countries_list.dart';
import 'package:coronavirus_visualizer/src/ui/utils/message_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryPickerScreen extends StatefulWidget {

  @override
  _CountryPickerScreenState createState() => _CountryPickerScreenState();
}

class _CountryPickerScreenState extends State<CountryPickerScreen> with SingleTickerProviderStateMixin{
  final _tabBarStyle = TextStyle(fontFamily: "Baloo", fontSize: 18, fontWeight: FontWeight.w500);
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this)..addListener(() {
      if (_controller.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick country", style: TextStyle(fontFamily: "Baloo", fontSize: 25, fontWeight: FontWeight.w600)),
        centerTitle: true,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs:[
            Tab(child: Text("All", style: _tabBarStyle)),
            Tab(child: Text("Saved", style: _tabBarStyle))
          ]
        )
      ),
      body: BlocListener<SavedCountriesBloc, SavedCountriesState>(
        listener: (context, state) {
          if (state is SavedCountriesError) {
            showErrorSnackbar(context, message: state.error);
          }
          if (state is SavedCountriesSuccess) {
            showSuccessSnackbar(context, message: state.message);
          }
        },
        child: TabBarView(
          controller: _controller,
          children: <Widget>[
            Container(
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
              child: AllCountriesList()
            ),
            Container(
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
              child: SavedCountriesList()
            ),
          ],
        ),
      )
    );
  }
}