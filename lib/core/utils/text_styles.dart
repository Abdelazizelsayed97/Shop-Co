import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  TextStyles._();

  static TextStyle boldFont({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Integral CF",
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
      decoration: decoration,
    );
  }

  static TextStyle regularFont({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontFamily: "Integral CF",
      shadows: shadows,
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w400,
      color: color ?? Colors.black,
      decoration: decoration,
    );
  }

  static TextStyle mediumFont({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Integral CF",
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w500,
      color: color ?? Colors.black,
      decoration: decoration,
    );
  }

  static TextStyle semiBoldFont({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Integral CF",
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w600,
      color: color ?? Colors.black,
      decoration: decoration,
    );
  }

  static TextStyle thinFont({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Integral CF",
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w200,
      color: color ?? Colors.black,
      decoration: decoration,
    );
  }

  static TextStyle extraBoldFont({
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: "Integral CF",
      fontSize: fontSize?.sp ?? 14.sp,
      fontWeight: FontWeight.w900,
      color: color ?? Colors.black,
      decoration: decoration,
    );
  }
}
