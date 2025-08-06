import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_test_task/AppState.dart';
import 'package:solid_test_task/utils.dart';

/// Component with current color action button
/// save if not saved, delete if it is
class ColorActions extends StatelessWidget {
  const ColorActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) {
        if (state.isColorSaved(state.currColor)) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _SavedBadge(),
              const SizedBox(width: 5),
              TextButton(
                onPressed: () => state.deleteFromSaved(state.currColor),
                child: Text(
                  "Delete from lib",
                  style: TextStyle(
                    color: state.currContrastColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          );
        }

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: state.currContrastColor,
          ),
          onPressed: () => state.addColorToSaved(state.currColor),
          child: Text(
            "Save color",
            style: TextStyle(color: getContrastColor(state.currContrastColor)),
          ),
        );
      },
    );
  }
}

class _SavedBadge extends StatelessWidget {
  const _SavedBadge();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) {
        return Container(
          padding: const EdgeInsets.fromLTRB(7, 3, 10, 3),
          decoration: BoxDecoration(
            color: state.currContrastColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.check, color: state.currColor, size: 18),
              const SizedBox(width: 4),
              Text("Saved", style: TextStyle(color: state.currColor)),
            ],
          ),
        );
      },
    );
  }
}
