import 'package:flutter/material.dart';
import 'package:solid_test_task/storage/prefsStorage.dart';
import 'package:solid_test_task/utils.dart';
import 'package:solid_test_task/widgets/ColorActions.dart';
import 'package:solid_test_task/widgets/ColorSplash.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ScreenState();
}

class _ScreenState extends State<ColorScreen> {
  late Color _color = _DefaultColor;
  List<Color> _saved = [];

  static const _DefaultColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final Color last =
        await PrefStorage.instance.getLastColor() ?? _DefaultColor;
    _setColor(last);

    final List<Color> lib = await PrefStorage.instance.getSavedColors();
    setState(() {
      _saved = lib;
    });
  }

  void _setColor(Color color) {
    PrefStorage.instance.saveLastColor(color);

    setState(() {
      _color = color;
    });
  }

  void _onSaveCurrColor() {
    setState(() {
      _saved = [..._saved, _color];
    });
    PrefStorage.instance.saveColorToLib(_color);
  }

  void _onDeleteColor(Color color) {
    PrefStorage.instance.getSavedColors();
    setState(() {
      _saved = _saved.where((c) => c != color).toList();
    });
    PrefStorage.instance.deleteColorFromLib(color);
  }

  @override
  Widget build(BuildContext context) {
    final Color contrastColor = getContrastColor(_color);
    const double _SplashSize = 60;

    return Scaffold(
      body: GestureDetector(
        onTap: () => _setColor(getRandomColor()),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,

          color: _color,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "Solid software Test task",
                    style: TextStyle(color: contrastColor, fontSize: 18),
                  ),
                ),

                Column(
                  children: [
                    Text(
                      'Hello there',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: contrastColor,
                      ),
                    ),
                    ColorActions(
                      onSave: _onSaveCurrColor,
                      onDelete: () => _onDeleteColor(_color),
                      saved: _saved,
                      curr: _color,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, bottom: 10),
                        child: Text(
                          "Saved colors",
                          style: TextStyle(fontSize: 17, color: contrastColor),
                        ),
                      ),

                      SizedBox(
                        height: _SplashSize + 8,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),

                                itemBuilder: (_, index) {
                                  final Color item = _saved[index];

                                  return ColorsLibItem(
                                    currColor: _color,
                                    size: _SplashSize,
                                    color: item,
                                    onSelect: _setColor,
                                  );
                                },
                                itemCount: _saved.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
