import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class listWheelScrollView extends StatelessWidget {
  final List<String> items;
  const listWheelScrollView(
      {super.key,
      required this.items,
      required Null Function(dynamic index) onSelectedItemChanged,
      required double itemExtent,
      required double overAndUnderCenterOpacity});

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      magnification: 1.3,
      useMagnifier: true,
      overAndUnderCenterOpacity: 0.19,
      physics: const FixedExtentScrollPhysics(),
      controller: FixedExtentScrollController(initialItem: items.length ~/ 2),
      itemExtent: 50,
      onSelectedItemChanged: (index) {
        // Handle the selected item change
        print(index);
      },
      diameterRatio: 1.5,
      children: items.map((level) {
        return Text(level,
            style: TextStyle(
              fontSize: 30,
              color: PrimaryColor,
              fontWeight: FontWeight.bold,
            ));
      }).toList(),
    );
  }

  static useDelegate(
      {required FixedExtentScrollController controller,
      required double itemExtent,
      required double magnification,
      required bool useMagnifier,
      required FixedExtentScrollPhysics physics,
      required Null Function(dynamic index) onSelectedItemChanged,
      required ListWheelChildBuilderDelegate childDelegate}) {}
}
