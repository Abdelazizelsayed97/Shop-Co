import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/responsive_by_media_query.dart';

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    super.key,
    this.onTap,
    this.colors,
    this.textColor,
    this.width,
    this.color,
    this.sideColor,
    this.child,
    this.padding,
    this.isLoading = false,
    this.height,
  });

  final VoidCallback? onTap;
  final List<Color>? colors;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? sideColor;
  final Widget? child;
  final EdgeInsets? padding;
  final bool isLoading;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  Timer? _debounceTimer;
  final Duration _debounceDuration = const Duration(milliseconds: 500);

  void _handleTap() {
    if (_debounceTimer?.isActive ?? false) return;

    widget.onTap?.call();

    _debounceTimer = Timer(_debounceDuration, () {});
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : _handleTap,
      child: Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12),
        height: widget.height ?? 48.0,
        width: widget.width ?? MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: widget.colors ?? [Colors.white, Colors.white],
          ),
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(color: widget.sideColor ?? Colors.transparent),
        ),
        child:
            widget.isLoading
                ? const CircularProgressIndicator()
                : Center(child: widget.child),
      ),
    );
  }
}

class GradientOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Gradient gradient;
  final double? value;
  final double? height;

  const GradientOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.gradient,
    this.value,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Padding(
        padding: ResponsivePadding.responsiveAll(value ?? 1),
        child: Container(
          height: height ?? 48.responsiveH(),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
