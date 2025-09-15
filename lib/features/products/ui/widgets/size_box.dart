import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeBox extends StatelessWidget {
  const SizeBox({super.key, required this.sizeText, required this.isSelected});
  final String sizeText;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.black,
          width: 1.5,
        ),
      ),
      child: Text(
        sizeText,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
