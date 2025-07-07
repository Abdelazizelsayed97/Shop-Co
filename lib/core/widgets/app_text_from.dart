// ignore_for_file: file_names

import 'package:e_commerce_web_app/core/utils/app_colors.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    this.textHint,
    this.icon,
    this.opsCureText,
    this.suffixIcon,
    required this.controller,
    required this.validator,
    this.label,
    this.onChanged,
    this.message,
    this.formatter,
    this.prefixText,
    this.onTap,
    this.borderColor,
    this.autoValidateMode,
    this.maxLines,
    this.maxLength,
    this.height,
    this.hasCounter,
    this.fillColor,
  });

  final TextEditingController controller;
  final String? label;
  final String? textHint;
  final String? prefixText;
  final Widget? icon;
  final bool? opsCureText;
  final Widget? suffixIcon;
  final Function(String?) validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final String? message;
  final List<TextInputFormatter>? formatter;
  final Color? borderColor;
  final AutovalidateMode? autoValidateMode;
  final int? maxLines;
  final int? maxLength;
  final double? height;
  final bool? hasCounter;
  final Color? fillColor;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final FocusNode focusNode = FocusNode();
  String? validationMessage;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        focusNode.canRequestFocus;
        validationMessage = widget.message;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.bottomCenter,

        decoration: BoxDecoration(
          color: widget.fillColor ?? Colors.white,
          border: Border.all(
            color: widget.borderColor ?? AppColors.borderSideColor,
          ),
          borderRadius: BorderRadius.circular(4.r),
        ),
        height: widget.height ?? 48.h,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: TextFormField(
          onTap: widget.onTap,
          inputFormatters: [if (widget.formatter != null) ...widget.formatter!],
          canRequestFocus: true,
          focusNode: focusNode,
          autofocus: false,
          onChanged: widget.onChanged,
          buildCounter: (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) {
            return widget.hasCounter == true
                ? Text(
                  "$currentLength/$maxLength",
                  style: TextStyles.regularFont(fontSize: 12),
                )
                : SizedBox.shrink();
          },
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          maxLines: widget.maxLines ?? 1,
          autovalidateMode:
              widget.autoValidateMode ?? AutovalidateMode.disabled,
          validator: (value) {
            String? message = widget.validator(value);
            validationMessage = message;
            return null;
          },
          textAlignVertical: TextAlignVertical.center,
          controller: widget.controller,
          obscureText: widget.opsCureText ?? false,
          cursorHeight: 8.responsiveH(),
          cursorRadius: Radius.circular(3.r),
          cursorColor: AppColors.primaryColor,
          showCursor: true,
          decoration: InputDecoration(
            hoverColor: Colors.transparent,
            prefixText: widget.prefixText,
            floatingLabelStyle: TextStyles.mediumFont(
              fontSize: 12,
              color: const Color(0xff858589),
            ),
            label: Padding(
              padding:
                  (focusNode.hasFocus || widget.controller.text.isNotEmpty)
                      ? ResponsivePadding.directional(top: 12.0)
                      : EdgeInsets.zero,
              child: Text(
                widget.label ?? '',
                style: TextStyles.mediumFont(color: AppColors.borderSideColor),
              ),
            ),
            suffixIconColor: AppColors.borderSideColor,
            suffixIcon: widget.suffixIcon,
            fillColor: widget.fillColor ?? Colors.transparent,
            filled: true,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            prefixIcon: widget.icon,
            hintStyle: TextStyles.regularFont(color: AppColors.grey_900),
          ),
        ),
      ),
      if (validationMessage != null && validationMessage!.isNotEmpty)
        verticalSpacer(4),
      if (validationMessage != null && validationMessage!.isNotEmpty)
        Text(
          validationMessage!,
          style: TextStyles.regularFont(fontSize: 10.sp, color: Colors.red),
        ),
    ],
  );
}

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String updatedText = newValue.text;
    if (updatedText.startsWith(" ")) {
      updatedText = updatedText.trimLeft();
    }
    // updatedText = updatedText.replaceAllMapped(RegExp(r'\s{2,}'), (match) {
    //   return " ";
    // });

    return newValue.copyWith(
      text: updatedText,
      selection: TextSelection.collapsed(offset: updatedText.length),
    );
  }
}

class NoDoubleSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(" ") || newValue.text.endsWith("")) {
      final trimmedText = newValue.text.trim();
      return TextEditingValue(selection: newValue.selection, text: trimmedText);
    }
    return newValue;
  }
}

class CreationTextForm extends StatelessWidget {
  const CreationTextForm({
    super.key,
    required this.controller,
    required this.onChange,
    this.textColor,
    this.inputColor,
  });

  final TextEditingController controller;
  final void Function(String?) onChange;
  final Color? textColor;
  final Color? inputColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsivePadding.symmetric(horizontal: 12),
      child: TextFormField(
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (newValue.text.startsWith(" ")) {
              final trimmed = newValue.text.trimLeft();
              final diff = newValue.text.length - trimmed.length;
              final newSelectionIndex = (newValue.selection.baseOffset - diff)
                  .clamp(0, trimmed.length);

              return TextEditingValue(
                text: trimmed,
                selection: TextSelection.collapsed(offset: newSelectionIndex),
              );
            }
            return newValue;
          }),
        ],
        controller: controller,
        onChanged: onChange,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          required maxLength,
        }) {
          return Align(
            alignment: Alignment.bottomRight,
            child: Text("$currentLength/$maxLength"),
          );
        },
        style: TextStyle(color: inputColor),
        maxLength: 500,
        autocorrect: false,
        cursorWidth: 2.responsiveW(),
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintStyle: TextStyles.regularFont(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: "How you can inspire others?",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
