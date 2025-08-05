import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:solid_test_task/storage/iStorage.dart';
import 'package:solid_test_task/storage/prefsStorage.dart';

class AppState extends ChangeNotifier {
  static const Color DefaultColor = Colors.white;
  Color _color = DefaultColor;

  final List<Color> _saved = [];

  final Storage storage = PrefStorage.instance;

  AppState() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final Color? last = await storage.getLastColor();

    _color = last ?? DefaultColor;

    final List<Color> saved = await storage.getSavedColors();
    _saved.addAll(saved);

    notifyListeners();
  }

  Color get currColor => _color;

  UnmodifiableListView<Color> get saved => UnmodifiableListView(_saved);

  void setCurrColor(Color upd) {
    _color = upd;
    storage.saveLastColor(currColor);

    notifyListeners();
  }

  void saveCurrColor() {
    if (_saved.contains(_color)) return;

    _saved.add(_color);
    storage.saveColorToLib(_color);

    notifyListeners();
  }

  void deleteFromSaved(Color color) {
    _saved.remove(color);
    storage.deleteColorFromLib(color);

    notifyListeners();
  }
}
