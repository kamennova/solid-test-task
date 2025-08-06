import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_test_task/AppState.dart';
import 'package:solid_test_task/utils.dart';

/// Shows user's collection of saved colors
class ColorsLib extends StatelessWidget {
  static const double _SplashSize = 60;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 10),
              child: Text(
                "Saved colors",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: state.currContrastColor,
                ),
              ),
            ),

            if (state.savedColors.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Nothing here yet!",
                  style: TextStyle(
                    color: state.currContrastColor,
                    fontSize: 15,
                  ),
                ),
              )
            else
              SizedBox(
                height: _SplashSize + _ColorsLibItem.SplashShadowSize * 2,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),

                        itemBuilder: (_, index) {
                          final Color item = state.savedColors[index];

                          return _ColorsLibItem(size: _SplashSize, color: item);
                        },
                        itemCount: state.savedColors.length,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ColorsLibItem extends StatelessWidget {
  final Color color;
  final double size;

  static const double SplashShadowSize = 3;

  const _ColorsLibItem({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) {
        final bool isSelected = state.currColor == color;

        return Padding(
          padding: const EdgeInsets.only(
            right: 13,
            bottom: SplashShadowSize,
            top: SplashShadowSize,
          ),
          child: InkWell(
            onTap: () => state.setCurrColor(color),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size,
                  height: size,

                  decoration: BoxDecoration(
                    color: color,

                    boxShadow: [
                      BoxShadow(
                        color: state.currContrastColor.withOpacity(0.2),
                        spreadRadius: SplashShadowSize,
                        blurRadius: SplashShadowSize,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 5,
                      color: state.currContrastColor,
                    ),
                  ),
                ),

                if (isSelected)
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: getContrastColor(color).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.check, color: color, size: 17),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
