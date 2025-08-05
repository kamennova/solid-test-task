import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_test_task/AppState.dart';
import 'package:solid_test_task/utils.dart';

class ColorsLib extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double _SplashSize = 60;

    return Consumer<AppState>(
      builder: (_, s, __) {
        final Color contrastColor = getContrastColor(s.currColor);

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
                  color: contrastColor,
                ),
              ),
            ),

            if (s.saved.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text("Nothing here yet!", 
                    style: TextStyle(color: contrastColor, fontSize: 15)),
              )
            else
              SizedBox(
                height: _SplashSize + 8,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),

                        itemBuilder: (_, index) {
                          final Color item = s.saved[index];

                          return ColorsLibItem(size: _SplashSize, color: item);
                        },
                        itemCount: s.saved.length,
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

class ColorsLibItem extends StatelessWidget {
  final Color color;
  final double size;

  const ColorsLibItem({required this.size, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, s, __) {
        final Color contrastColor = getContrastColor(s.currColor);
        final bool isSelected = s.currColor == color;

        return Padding(
          padding: const EdgeInsets.only(right: 13, bottom: 4, top: 4),
          child: InkWell(
            onTap: () => s.setCurrColor(color),
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
                        color: Colors.grey.shade500,
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 5, color: contrastColor),
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
