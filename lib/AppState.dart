import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:solid_test_task/storage/iStorage.dart';
import 'package:solid_test_task/storage/prefsStorage.dart';
import 'package:solid_test_task/utils.dart';

class AppState extends ChangeNotifier {
  /// shown on first app open and while loading last shown color from storage
  static const Color DefaultColor = Colors.white;

  Color _color = DefaultColor;
  final List<Color> _saved = [];

  final Storage _storage = PrefStorage.instance;

  /// color of main screen
  Color get currColor => _color;

  /// contrasting color of current main screen color
  /// used in main screen elements to ensure good visibility
  ///
  /// not very good that it re-computes value each time its called, but
  /// getContrastColor is not a very expensive operation
  Color get currContrastColor => getContrastColor(_color);

  // colors user saved
  UnmodifiableListView<Color> get savedColors => UnmodifiableListView(_saved);

  AppState() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final Color? last = await _storage.getLastShownColor();
    _color = last ?? DefaultColor;

    final List<Color> saved = await _storage.getSavedColors();
    _saved.clear();
    _saved.addAll(saved);

    notifyListeners();
  }

  /// update curr color of main screen
  /// and persist it to show it first on next app open
  void setCurrColor(Color upd) {
    _color = upd;
    _storage.saveLastShownColor(currColor);

    notifyListeners();
  }

  /// save color to user's color collection
  void addColorToSaved(Color toSave) {
    if (_saved.contains(toSave)) return;

    _saved.insert(0, toSave);
    _storage.addColorToSaved(toSave);

    notifyListeners();
  }

  void deleteFromSaved(Color color) {
    _saved.remove(color);
    _storage.deleteColorFromSaved(color);

    notifyListeners();
  }

  bool isColorSaved(Color toCheck) => _saved.contains(toCheck);
}
