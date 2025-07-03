import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color primaryColor = const Color(0xff4880FF);
  static Color borderSideColor = const Color(0xff9D9C99);
  static Color disabledIndicatorColor = const Color(0xffE0E0E0);
  static Color appBackGroundColor = const Color(0xffFFFFFF);
  static Color forgetPasswordColor = const Color(0xff6A717F);
  static Color regionContainerBackColor = const Color(0xffF5F5F5);

  static Gradient orangeRedGradient = const LinearGradient(
    colors: <Color>[Color(0xffEF3E2C), Color(0xffE71F63)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Gradient transparentGradient = const LinearGradient(
    colors: <Color>[Colors.transparent, Colors.transparent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Gradient greenAccentGreenGradient = const LinearGradient(
    colors: <Color>[Colors.green, Colors.greenAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Gradient unSelectedTabGradient = const LinearGradient(
    colors: <Color>[Colors.white, Colors.white70],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static List<Color> orangeRedGradientList = [
    const Color(0xffEF3E2C),
    const Color(0xffE71F63),
  ];
  static List<Color> greenAccentGreenGradientList = [
    Colors.green,
    Colors.lightGreen,
  ];
  static List<Color> disableGradientList = [
    const Color(0xccCCCCCC),
    const Color(0xccCCCCCC),
  ];

  static List<Color> firstScreenShadow = [
    const Color(0xff8B4EFF).withAlpha(89), // 0.35 * 255 = 89
    const Color(0xff6549FF).withAlpha(51), // 0.2 * 255 = 51
    const Color(0x056549FF).withAlpha(13), // 0.05 * 255 = 13
  ];

  static List<Color> unFollowListColors = [Colors.black, Colors.black54];

  static List<Color> secondScreenShadow = [
    const Color(0xff04FFAA).withAlpha(89), // 0.35 * 255 = 89
    const Color(0xff00F2D0).withAlpha(51), // 0.2 * 255 = 51
    const Color(0x0500F2D0).withAlpha(3), // 0.01 * 255 = 3
  ];

  static List<Color> thirdScreenShadow = [
    const Color(0xff241C60).withAlpha(128), // 0.5 * 255 = 128
    const Color(0xff171047).withAlpha(64), // 0.25 * 255 = 64
    const Color(0x00171047).withAlpha(13), // 0.05 * 255 = 13
  ];
  static const Color grey_900 = Color(0xFF858589);
  static const Color white500 = Color(0xffE0E0E0);
  static const Color white100 = Color(0xffF5F5F5);
  static const Color grey_700 = Color(0xff858589);
}
