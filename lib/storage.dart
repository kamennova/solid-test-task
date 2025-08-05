import 'dart:developer';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage instance = Storage._privateConstructor();

  static SharedPreferences? _prefs;

  static const String _LastColorKey = "last_color";
  static const String _SavedColorsKey = "saved_colors";

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();

    return Future.value(_prefs);
  }

  Storage._privateConstructor();

  Future<Color?> getLastColor() async {
    final Object? res = (await prefs).get(_LastColorKey);
    log(res?.toString() ?? 'no color');
    if (res == null) return null;

    return parseColorStr(res as String);
  }

  Future<void> saveLastColor(Color color) async {
    await (await prefs).setString(_LastColorKey, getColorStr(color));
  }

  Future<void> saveColorToLib(Color color) async {
    final SharedPreferences pr = await prefs;

    List<Color> saved = await getColorsLib();

    if (saved.any((c) => c == color)) return;
    final List<String> toStr = [...saved, color].map(getColorStr).toList();

    await pr.setStringList(_SavedColorsKey, toStr);
  }

  Future<List<Color>> getColorsLib() async {
    final SharedPreferences pr = await prefs;

    final Object? value = pr.get(_SavedColorsKey);

    if (value == null) return [];

    return (value as List<String>).map(parseColorStr).toList();
  }
}

String getColorStr(Color color) {
  return [color.r.toString(), color.g.toString(), color.b.toString()].join(".");
}

Color parseColorStr(String value) {
  final List<int> channels = value.split(".").map(int.parse).toList();

  return Color.fromRGBO(channels.first, channels[1], channels[2], 1);
}
