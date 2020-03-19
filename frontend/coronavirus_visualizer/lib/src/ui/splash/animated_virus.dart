


import 'package:flutter/widgets.dart';

class AnimatedVirus extends StatefulWidget {

  @override
  State<AnimatedVirus> createState() => _AnimatedVirusState();
}

class _AnimatedVirusState extends State<AnimatedVirus> with TickerProviderStateMixin {
  final _baseVirusOffset = Offset(0, 200);
  final _imageSize = Offset(100, 100);

  AnimationController _firstController;
  AnimationController _secondController;
  AnimationController _thirdController;
  Animation<double> _firstVirus;
  Animation<double> _secondVirus;
  Animation<double> _thirdVirus;


  @override
  void initState() {
    _firstController = AnimationController(vsync: this, duration:  Duration(milliseconds: 1200), );
    _secondController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _thirdController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    final curve1 = CurvedAnimation(curve: Curves.easeInOutSine, parent: _firstController);
    final curve2 = CurvedAnimation(curve: Curves.easeInOutSine, parent: _secondController);
    final curve3 = CurvedAnimation(curve: Curves.easeInOutSine, parent: _thirdController);

    _firstVirus = Tween<double>(begin: -150, end: -50).animate(curve1)..addListener(() => setState(() {}));
    _secondVirus = Tween<double>(begin: -50, end: 50).animate(curve2);
    _thirdVirus = Tween<double>(begin: -50, end: 50).animate(curve3);



    _firstController.forward();
    _secondController.forward();
    _thirdController.forward();

    _firstController.repeat(reverse: true);
    _secondController.repeat(reverse: true);
    _thirdController.repeat(reverse: true);
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: _baseVirusOffset.dy + _firstVirus.value,
          right: 0,
          left: 0,
          child: Image.asset("assets/red_virus.png", height: _imageSize.dy, width: _imageSize.dx)
        ),
        Positioned(
          top: _baseVirusOffset.dy + _secondVirus.value,
          left: 50,
          child: Image.asset("assets/red_virus.png", height: _imageSize.dy, width: _imageSize.dx)
        ),
        Positioned(
          top: _baseVirusOffset.dy + _thirdVirus.value,
          right: 50,
          child: Image.asset("assets/red_virus.png", height: _imageSize.dy, width: _imageSize.dx)
        ),
      ],
    );
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    super.dispose();
  }
}