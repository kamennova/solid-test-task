import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_test_task/AppState.dart';
import 'package:solid_test_task/utils.dart';

class ColorActions extends StatelessWidget {
  const ColorActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) {
        final contrastColor = getContrastColor(state.currColor);

        if (state.saved.contains(state.currColor)) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SavedBadge(color: state.currColor),
              const SizedBox(width: 5),
              TextButton(
                onPressed: () => state.deleteFromSaved(state.currColor),
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
          onPressed: Provider.of<AppState>(
            context,
            listen: false,
          ).saveCurrColor,
          child: Text(
            "Save color",
            style: TextStyle(color: getContrastColor(contrastColor)),
          ),
        );
      },
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
        color: getContrastColor(context.watch<AppState>().currColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.check, color: context.watch<AppState>().currColor, size: 18),
          const SizedBox(width: 4),
          Text(
            "Saved",
            style: TextStyle(color: context.watch<AppState>().currColor),
          ),
        ],
      ),
    );
  }
}
