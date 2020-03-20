

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'dart:math' as math;

class ErrorScreen extends StatefulWidget {
  final String error;

  ErrorScreen({@required this.error});

  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> with TickerProviderStateMixin {

  AnimationController _resizeController;
  AnimationController _shakeController;
  Animation<double> _roatation;
  Animation<double> _size;
  Animation<Color> _color;

  @override
  void initState() { 
    _resizeController = AnimationController(vsync: this, duration: Duration(seconds: 2))..addListener(() => setState(() {}));
    _shakeController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    final _sizeCurve = CurvedAnimation(curve: Curves.easeInOutSine, parent: _resizeController);
    _size = Tween<double>(begin: 0.8, end: 1.2).animate(_sizeCurve);
    _color = ColorTween(begin: Colors.white, end: Colors.red).animate(_sizeCurve);

    final _rotationCurve = CurvedAnimation(curve: Curves.bounceInOut, parent: _shakeController);
    _roatation = Tween<double>(begin: -math.pi/12, end: math.pi/12).animate(_shakeController);

    _resizeController.forward();
    _shakeController.forward();

    _resizeController.repeat(reverse: true);
    _shakeController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _resizeController.dispose();
    _shakeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          // center: const Alignment(0.7, -0.6), // near the top right
          radius: 0.7,
          colors: [
            const Color(0xFF353535), // yellow sun
            const Color(0xFF111111), // blue sky
          ],
          stops: [0.4, 1.0],
        )
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Transform.scale(
                scale: _size.value,
                child: Transform.rotate(
                  angle: _roatation.value,
                  child: Image.asset("assets/red_virus.png", height: 200, width: 200)
                )
              ),
            ),
            Positioned(
            bottom: 120,
            left: 60,
            right: 60,
            child: Text(widget.error, style: TextStyle(fontFamily: "Baloo", color: _color.value, fontSize: 25), textAlign: TextAlign.center,)
          )

        ],
      )
    );
  }
}