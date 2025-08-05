import 'dart:ui';

abstract class IStorage {
  Future<Color?> getLastColor();

  Future<void> saveLastColor(Color color);

  Future<void> saveColorToLib(Color color);

  Future<void> deleteColorFromLib(Color color);

  Future<List<Color>> getSavedColors();
}
