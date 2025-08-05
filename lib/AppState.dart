import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:solid_test_task/storage/prefsStorage.dart';

class AppState extends ChangeNotifier {
  static const Color DefaultColor = Colors.white;
  Color _color = DefaultColor;

  final List<Color> _saved = [];

  Color get color => _color;

  UnmodifiableListView<Color> get saved => UnmodifiableListView(_saved);

  void setCurrColor(Color upd) {
    _color = upd;
    PrefStorage.instance.saveLastColor(color);
    notifyListeners();
  }

  void saveCurrColor() {
    if (_saved.contains(_color)) return;

    _saved.add(_color);
    notifyListeners();
  }

  void deleteFromSaved(Color color) {
    _saved.remove(color);
    PrefStorage.instance.deleteColorFromLib(color);

    notifyListeners();
  }
}