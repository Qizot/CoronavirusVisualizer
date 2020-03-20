

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MysteriousImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bombowiec", style: TextStyle(fontFamily: "Baloo", fontSize: 25, color: Colors.white)),
        centerTitle: true,
      ),
      body: Image.asset("assets/lolek.png", width: size.width, height: size.height, fit: BoxFit.fill)
    );
  }
}