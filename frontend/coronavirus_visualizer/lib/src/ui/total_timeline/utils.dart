import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final defaultGradientDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  gradient: LinearGradient(
    colors: [
      const Color(0xFF353535), // yellow sun
      const Color(0xFF111111), 
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black,
      blurRadius: 20.0,
      spreadRadius: 5.0,
      offset: Offset(
        10,
        10
      )
    )
  ]
);
 