import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveContext {
  SaveContext._();

  static final SaveContext instance = SaveContext._();

  BuildContext? context;

  void setBuildContext(BuildContext context) {
    if (context == null) {
      context = context;
    }
  }
}

bool isLandScape =
    MediaQuery.of(SaveContext.instance.context!).orientation ==
    Orientation.landscape;
double responsiveFontSize(double fontSize) {
  double fp = 0;
  var context = SaveContext.instance.context;
  if (context != null) {
    fp = MediaQuery.of(context).textScaler.scale(fontSize);
  }
  return fp;
}

double responsiveFontSizePx(double fontSize) {
  double fp = 0;
  double h = 0;
  var context = SaveContext.instance.context;
  if (context != null) {
    h = MediaQuery.of(context).size.height;
  }
  fp = (fontSize * h) / 812.0;
  return fp;
}

extension ResponsiveFontSize on double {
  double responsiveString({BuildContext? context}) {
    double h = 0;
    var context = SaveContext.instance.context;
    if (context != null) {
      h = MediaQuery.of(context).size.height;
    }

    return (this * h) / 812.0;
  }
}

double getResponsiveHeight(double givenHeight) {
  double screenHeight = 0;
  var context = SaveContext.instance.context;
  if (context != null) {
    screenHeight = MediaQuery.of(context).size.height;

    if (kDebugMode) {}
    MediaQuery.of(context).orientation;
  }

  const double basicDesignHeight = 812.0;

  return (givenHeight / basicDesignHeight) * screenHeight;
}

double getResponsiveWidth(double givenWidth) {
  var context = SaveContext.instance.context;

  double screenWidth = 0;

  if (context != null) {
    screenWidth = MediaQuery.of(context).size.width;
    if (kDebugMode) {}
  }

  const double basicDesignWidth = 375.0;

  return (givenWidth / basicDesignWidth) * screenWidth;
}

extension ResponsiveWidth on int {
  double responsiveW() {
    final context = SaveContext.instance.context;

    if (context != null) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (kDebugMode) {}

      const double basicDesignWidth = 375.0;
      return (toDouble() / basicDesignWidth) * screenWidth;
    }

    // If context is null, return the original value as double
    return toDouble();
  }
}

extension ResponsiveHeight on int {
  double responsiveH() {
    final context = SaveContext.instance.context;

    if (context != null) {
      double screenHeight = MediaQuery.of(context).size.height;
      if (kDebugMode) {}

      const double basicDesignHeight = 812.0;
      return (toDouble() / basicDesignHeight) * screenHeight;
    }

    // If context is null, return the original value as double
    return toDouble();
  }
}

SizedBox verticalSpacer(double height) {
  return SizedBox(height: getResponsiveHeight(height));
}

SizedBox horizontalSpacer(double width) {
  return SizedBox(width: getResponsiveWidth(width));
}

class ResponsivePadding extends EdgeInsets {
  ///Customize your all directions padding

  ResponsivePadding.responsiveAll(double value)
    : super.fromLTRB(
        getResponsiveWidth(value),
        getResponsiveHeight(value),
        getResponsiveWidth(value),
        getResponsiveHeight(value),
      );

  /// Constants padding for use.
  /// All references to padding for all directions

  ResponsivePadding.all4()
    : super.fromLTRB(
        getResponsiveWidth(4),
        getResponsiveHeight(4),
        getResponsiveWidth(4),
        getResponsiveHeight(4),
      );

  ResponsivePadding.all8()
    : super.fromLTRB(
        getResponsiveWidth(8),
        getResponsiveHeight(8),
        getResponsiveWidth(8),
        getResponsiveHeight(8),
      );

  ResponsivePadding.all12()
    : super.fromLTRB(
        getResponsiveWidth(12),
        getResponsiveHeight(12),
        getResponsiveWidth(12),
        getResponsiveHeight(12),
      );

  ResponsivePadding.all16()
    : super.fromLTRB(
        getResponsiveWidth(16),
        getResponsiveHeight(16),
        getResponsiveWidth(16),
        getResponsiveHeight(16),
      );

  ResponsivePadding.all20()
    : super.fromLTRB(
        getResponsiveWidth(20),
        getResponsiveHeight(20),
        getResponsiveWidth(20),
        getResponsiveHeight(20),
      );

  /// Customize your symmetric padding by responsiveSymmetric

  ResponsivePadding.symmetric({double? horizontal, double? vertical})
    : super.symmetric(
        horizontal: getResponsiveWidth(horizontal ?? 0),
        vertical: getResponsiveHeight(vertical ?? 0),
      );

  /// Symmetric H references horizontal direction.
  /// Symmetric V references vertical direction.

  ResponsivePadding.symmetricH8()
    : super.symmetric(horizontal: getResponsiveWidth(8));
  ResponsivePadding.symmetricH4()
    : super.symmetric(horizontal: getResponsiveWidth(4));

  ResponsivePadding.symmetricV8()
    : super.symmetric(vertical: getResponsiveHeight(8));

  ResponsivePadding.symmetricV12()
    : super.symmetric(vertical: getResponsiveHeight(12));

  ResponsivePadding.symmetricH12()
    : super.symmetric(horizontal: getResponsiveWidth(12));

  ResponsivePadding.symmetricH16()
    : super.symmetric(horizontal: getResponsiveWidth(16));

  ResponsivePadding.symmetricH20()
    : super.symmetric(horizontal: getResponsiveWidth(20));

  ResponsivePadding.symmetricV20()
    : super.symmetric(vertical: getResponsiveHeight(20));

  ///for one direction

  ResponsivePadding.directional({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) : super.fromLTRB(
         getResponsiveWidth(right ?? 0),
         getResponsiveHeight(top ?? 0),
         getResponsiveWidth(left ?? 0),
         getResponsiveHeight(bottom ?? 0),
       );
}

extension ResponsivePaddingExtension on int {
  Widget responsiveWidth() {
    var context = SaveContext.instance.context;

    double screenWidth = 0;

    if (context != null) {
      screenWidth = MediaQuery.of(context).size.width;
      if (kDebugMode) {}
    }

    const double basicDesignWidth = 375.0;

    var x = (this / basicDesignWidth) * screenWidth;
    return SizedBox(width: x);
  }
}

extension ResponsiveSpaceExtension on int {
  Widget responsiveHeight() {
    return SizedBox(height: this.h);
  }
}
