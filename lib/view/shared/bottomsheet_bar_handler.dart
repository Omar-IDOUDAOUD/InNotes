import 'package:flutter/material.dart';

class BottomSheetDragHandlerBar extends StatelessWidget {
  const BottomSheetDragHandlerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 5,
          width: 40,
          child: DecoratedBox(
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).hintColor,
          )),
        ),
      ),
    );
  }
}
