import 'dart:ui';

abstract class Storage {
  /// get the last color shown on main screen
  Future<Color?> getLastColor();

  // save the last color shown on main screen
  Future<void> saveLastColor(Color color);

  /// save color to user's color collection
  Future<void> saveColorToLib(Color color);

  // delete color from user's color collection
  Future<void> deleteColorFromLib(Color color);

  // get user's color collection
  Future<List<Color>> getSavedColors();
}
