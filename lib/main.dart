import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.white;
  bool _isLight = true;
  final Random _generator = Random();


  static const int maxChannel = 255;

  int _getRandomChannel() {
    return _generator.nextInt(maxChannel + 1);
  }

  bool _getIsLight(Color color) {
    return color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722 > 0.5;
  }

  String _colorToStr(Color color) {
return [color.r.toString(), color.g.toString(), color.b.toString()].join(".");
  }

  Color _colorFromStr(String value) {
    final List<int> channels = value.split(".").map(int.parse).toList();
    
    return Color.fromRGBO(channels.first, channels[1], channels[2], 1);
  }

  Future<void> _saveLastColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("last_color", _colorToStr(_color));
    // prefs.setStringList(key, value)
  }

  Future<void> _updateColorsLib(List<Color> colors) async {

  }

  void _updateColors() {
    final Color res = _generateColor();
    final bool isLight = _getIsLight(res);
    
    _saveLastColor();

    setState(() {
      _color = res;
      _isLight = isLight;
    });
  }

  Color _generateColor() {
    final int r = _getRandomChannel(),
        g = _getRandomChannel(),
        b = _getRandomChannel();

    return Color.fromRGBO(r, g, b, 1);
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      Object? lastValue = prefs.get("last_color");
      if (lastValue != null) {
        setState(() {
          _color = _colorFromStr(lastValue.toString());
        });
      }
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
        onTap: _updateColors,
        child: Container(
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
                ElevatedButton(onPressed: (){}, child: Text("Save to lib"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
