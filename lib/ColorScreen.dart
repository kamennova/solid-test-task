import 'package:flutter/material.dart';
import 'package:solid_test_task/storage.dart';
import 'package:solid_test_task/utils.dart';

class ColorScreen extends StatefulWidget {
  final Color? initColor;

  const ColorScreen({super.key, this.initColor});

  @override
  State<ColorScreen> createState() => _ScreenState();
}

class _ScreenState extends State<ColorScreen> {
  late Color _color;
  bool _isLight = true;

  List<Color> _saved = [];

  @override
  void initState() {
    super.initState();

    _color = widget.initColor ?? Colors.white;
  }

  void _setColor(Color color) {
    final bool isLight = isColorLight(color);

    Storage.instance.saveLastColor(color);

    setState(() {
      _color = color;
      _isLight = isLight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Solid Software test task"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => _setColor(getRandomColor()),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,

          color: _color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello there',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: _isLight ? Colors.black : Colors.white,
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text("Save to lib")),

                // ignore: avoid_unused_parameters
                SizedBox(height: 60, child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context, index) {
                          final Color item = _saved[index];

                          return InkWell(
                            onTap: () => _setColor(item),
                            child: Container(
                              width: 50,
                              height: 50,

                              decoration: BoxDecoration(color: item),
                            ),
                          );
                        },
                        itemCount: _saved.length,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
