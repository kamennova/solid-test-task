import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Solid Software test task"),
    centerTitle: true,
    ),
    body: Center(child: Text("Loading"),));
  }

}