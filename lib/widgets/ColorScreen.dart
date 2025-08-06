import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_test_task/AppState.dart';
import 'package:solid_test_task/utils.dart';
import 'package:solid_test_task/widgets/ColorActions.dart';
import 'package:solid_test_task/widgets/ColorsLib.dart';

/// Main colored screen of the App
class ColorScreen extends StatelessWidget {
  const ColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) {
        return Scaffold(
          body: GestureDetector(
            onTap: () => state.setCurrColor(getRandomColor()),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              color: state.currColor,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "Solid software Test task",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: state.currContrastColor,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        Text(
                          'Hello there',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: state.currContrastColor,
                          ),
                        ),
                        const ColorActions(),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ColorsLib(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
