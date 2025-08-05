import 'package:flutter/material.dart';
import 'package:solid_test_task/utils.dart';

class ColorActions extends StatelessWidget {
  final List<Color> saved;
  final Color curr;
  final Function() onDelete;
  final Function() onSave;

  const ColorActions({
    super.key,
    required this.onSave,
    required this.onDelete,
    required this.saved,
    required this.curr,
  });

  @override
  Widget build(BuildContext context) {
    final contrastColor = getContrastColor(curr);

    if (saved.contains(curr)) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SavedBadge(color: curr),
          const SizedBox(width: 5),
          TextButton(
            onPressed: onDelete,
            child: Text(
              "Delete from lib",
              style: TextStyle(color: contrastColor, fontSize: 17),
            ),
          ),
        ],
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: contrastColor),
      onPressed: onSave,
      child: Text(
        "Save color",
        style: TextStyle(color: getContrastColor(contrastColor)),
      ),
    );
  }
}

class _SavedBadge extends StatelessWidget {
  final Color color;

  const _SavedBadge({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 3, 10, 3),
      decoration: BoxDecoration(
        color: getContrastColor(color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.check, color: color, size: 18),
          const SizedBox(width: 4),
          Text("Saved", style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
