import 'dart:ui';

abstract class Storage {
  /// get the last color shown on main screen
  Future<Color?> getLastShownColor();

  /// save the last color shown on main screen
  Future<void> saveLastShownColor(Color color);

  /// save color to user's color collection
  Future<void> addColorToSaved(Color color);

  /// delete color from user's color collection
  Future<void> deleteColorFromSaved(Color color);

  /// get user's color collection
  Future<List<Color>> getSavedColors();
}
