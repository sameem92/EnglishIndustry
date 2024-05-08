import 'package:flutter/material.dart';

class DayShapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {    
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.001489203, size.height * 0.9144951);
    path_0.cubicTo(
        size.width * 0.001489203,
        size.height * 0.9910423,
        size.width * 0.08637379,
        size.height * 1.029316,
        size.width * 0.1355175,
        size.height * 0.9739414);
    path_0.cubicTo(
        size.width * 0.2285927,
        size.height * 0.8713355,
        size.width * 0.3574088,
        size.height * 0.8070033,
        size.width * 0.5003723,
        size.height * 0.8070033);
    path_0.cubicTo(
        size.width * 0.6433358,
        size.height * 0.8070033,
        size.width * 0.7714073,
        size.height * 0.8705212,
        size.width * 0.8644825,
        size.height * 0.9739414);
    path_0.cubicTo(
        size.width * 0.9128816,
        size.height * 1.027687,
        size.width * 0.9985108,
        size.height * 0.9902280,
        size.width * 0.9985108,
        size.height * 0.9144951);
    path_0.lineTo(size.width * 0.9985108, size.height * 0.08550489);
    path_0.cubicTo(size.width * 0.9985108, size.height * 0.03908795,
        size.width * 0.9635145, 0, size.width * 0.9203276, 0);
    path_0.lineTo(size.width * 0.07967238, 0);
    path_0.cubicTo(
        size.width * 0.03648548,
        0,
        size.width * 0.001489203,
        size.height * 0.03827362,
        size.width * 0.001489203,
        size.height * 0.08550489);
    path_0.lineTo(size.width * 0.001489203, size.height * 0.9144951);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(oldClipper) => true;
}
