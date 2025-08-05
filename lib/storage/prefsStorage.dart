import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_test_task/storage/iStorage.dart';

class PrefStorage implements Storage {
  static final PrefStorage instance = PrefStorage._privateConstructor();

  static SharedPreferences? _prefs;

  static const String _LastColorKey = "last_color";
  static const String _SavedColorsKey = "saved_colors";

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();

    return Future.value(_prefs);
  }

  PrefStorage._privateConstructor();

  Future<Color?> getLastColor() async {
    final Object? res = (await prefs).get(_LastColorKey);
    if (res == null) return null;

    return _parseColorStr(res as String);
  }

  Future<void> saveLastColor(Color color) async {
    final SharedPreferences pr = await prefs;
    await pr.setString(_LastColorKey, _getColorStr(color));
  }

  Future<void> saveColorToLib(Color color) async {
    final SharedPreferences pr = await prefs;

    final List<Color> saved = await getSavedColors();
    final List<String> toStr = [...saved, color].map(_getColorStr).toList();

    await pr.setStringList(_SavedColorsKey, toStr);
  }

  Future<void> deleteColorFromLib(Color color) async {
    final SharedPreferences pr = await prefs;

    final List<Color> saved = await getSavedColors();

    final List<String> updated = saved
        .where((c) => c != color)
        .map(_getColorStr)
        .toList();

    await pr.setStringList(_SavedColorsKey, updated);
  }

  Future<List<Color>> getSavedColors() async {
    final SharedPreferences pr = await prefs;

    final Object? value = pr.get(_SavedColorsKey);

    if (value == null) return [];

    return (value as List<String>).map(_parseColorStr).toList();
  }

  static String _getColorStr(Color color) {
    return color.toARGB32().toString();
  }

  static Color _parseColorStr(String value) {
    return Color(int.parse(value));
  }
}
