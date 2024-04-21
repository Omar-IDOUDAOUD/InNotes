import 'package:flutter/material.dart';

class AppBarUnderScrollFaceBox extends StatelessWidget {
  const AppBarUnderScrollFaceBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 17,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}
