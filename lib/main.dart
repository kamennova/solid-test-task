import 'package:flutter/material.dart';
import 'package:solid_test_task/ColorScreen.dart';
import 'package:solid_test_task/LoadingScreen.dart';
import 'package:solid_test_task/storage.dart';

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
      home: FutureBuilder<Color?>(
        future: Storage.instance.getLastColor(),
        builder: (_, data) {
          if (!data.hasData) return LoadingScreen();

          return ColorScreen(initColor: data.data);
        },
      ),
    );
  }
}
