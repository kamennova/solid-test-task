import 'package:flutter/material.dart';
import 'package:solid_test_task/utils.dart';

class ColorsLibItem extends StatelessWidget {
  final Color color;
  final Function(Color) onSelect;
  final double size;
  final Color currColor;

  const ColorsLibItem({
    required this.currColor,
    required this.size,
    required this.color,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currColor == color;
    final contrastColor = getContrastColor(currColor);

    return Padding(
      padding: const EdgeInsets.only(right: 13, bottom: 4, top: 4),
      child: InkWell(
        onTap: () => onSelect(color),
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
  }
}
