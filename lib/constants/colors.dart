import 'package:flutter/material.dart' show Color, Colors, MaterialColor;

abstract class ColorsConsts {
  static final List<Color> textColors = [
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];
  static final List<Color> textBackroundColors = [
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.purple.shade200,
    Colors.pink.shade200,
  ];
  static final flagsColors = [
    Colors.grey,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.brown,
  ];
  static final notesColorsLight = [
    Colors.teal,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
  ];
  static final List<MaterialColor> notesColorsDark = [
    Colors.teal,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
  ];
  static final selectedWidgetLight = Colors.indigo.shade800; 
  static final selectedWidgetDark = Colors.indigo.shade100; 
}
