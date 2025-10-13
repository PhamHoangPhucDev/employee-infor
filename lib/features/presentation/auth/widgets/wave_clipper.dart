// Wave Clipper for animated wave effect
import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;

  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();
    final double waveHeight = 20;
    final double frequency = 2 * math.pi / size.width;

    path.lineTo(0, size.height - waveHeight);

    for (double x = 0; x <= size.width; x++) {
      final double y = size.height -
          waveHeight +
          math.sin((x * frequency) + (animationValue * 2 * math.pi)) * waveHeight;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}