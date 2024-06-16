import 'dart:math';

import 'package:flutter/material.dart';

class ThemeClipper extends CustomClipper<Path> {
  final double percent;

  ThemeClipper(this.percent);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addArc(
      Rect.fromCenter(
        center: Offset(size.width - 40, 40),
        width: size.width * percent,
        height: size.width * percent,
      ),
      0.0,
      pi * 2,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
