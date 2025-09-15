import 'package:flutter/material.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({super.key, required this.color, required this.isSelected});
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 1.2,
        ),
      ),
    );
  }
}
