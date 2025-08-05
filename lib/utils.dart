import 'dart:math';
import 'dart:ui';

const int _ColorMaxChannel = 255;

int _getRandomChannel() {
  return Random().nextInt(_ColorMaxChannel + 1);
}

bool isColorLight(Color color) {
  return color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722 > 0.5;
}

Color getRandomColor() {
  final int r = _getRandomChannel(),
      g = _getRandomChannel(),
      b = _getRandomChannel();

  return Color.fromRGBO(r, g, b, 1);
}
