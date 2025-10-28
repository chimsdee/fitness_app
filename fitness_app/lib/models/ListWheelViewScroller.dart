// ignore_for_file: file_names, camel_case_types

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class ListWheelScrollViewWrapper extends StatelessWidget {
  final List<String> items;
  final Function(int) onSelectedItemChanged;
  final double itemExtent;
  final double overAndUnderCenterOpacity;
  final FixedExtentScrollController? controller;

  const ListWheelScrollViewWrapper({
    super.key,
    required this.items,
    required this.onSelectedItemChanged,
    required this.itemExtent,
    this.overAndUnderCenterOpacity = 0.3,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: itemExtent,
      magnification: 1.3,
      useMagnifier: true,
      overAndUnderCenterOpacity: overAndUnderCenterOpacity,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, index) {
          if (index < 0 || index >= items.length) return null;
          return Text(
            items[index],
            style: const TextStyle(
              fontSize: 30,
              color: PrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}