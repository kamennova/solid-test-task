import 'dart:math';

import 'package:flutter/material.dart';

const int _ColorMaxChannel = 255;

int _getRandomChannel() {
  return Random().nextInt(_ColorMaxChannel + 1);
}

/// this calculates the relative luminance of color
/// and checks if it's above medium (on the light side)
bool isColorLight(Color color) {
  // ignore: no_magic_number
  return color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722 > 0.5;
}

Color getRandomColor() {
  final int r = _getRandomChannel(),
      g = _getRandomChannel(),
      b = _getRandomChannel();

  return Color.fromRGBO(r, g, b, 1);
}

Color getContrastColor(Color color) =>
    isColorLight(color) ? Colors.black : Colors.white;
