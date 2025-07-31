import 'package:e_commerce_web_app/core/utils/app_colors.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(PhoneNumber)? onChanged;
  final dynamic Function(PhoneNumber?) validation;
  final String? validationMessage;
  final String? hintText;

  const PhoneTextField({
    super.key,
    required this.controller,
    this.onChanged,
    required this.validation,
    this.validationMessage,
    this.hintText,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final FocusNode focusNode = FocusNode();
  String? validationMessage;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        focusNode.canRequestFocus;
        validationMessage = widget.validationMessage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          color: Colors.white,
          child: IntlPhoneField(
            focusNode: focusNode,
            autofocus: false,
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: AppColors.primaryColor,
            showCountryFlag: false,
            dropdownIconPosition: IconPosition.trailing,
            flagsButtonPadding: ResponsivePadding.symmetricH4(),
            flagsButtonMargin: ResponsivePadding.symmetricH16(),
            dropdownDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.merge(
                Border(right: BorderSide(color: AppColors.borderSideColor)),
                const Border(),
              ),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding: ResponsivePadding.all16(),
              focusColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderSideColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderSideColor),
              ),
              counter: const SizedBox.shrink(),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.borderSideColor),
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
              ),
            ),
            languageCode: "en",
            onChanged: widget.onChanged,
            onCountryChanged: (country) {
              widget.controller.clear();
              setState(() {});
            },
            validator: (p0) {
              String? message = widget.validation(p0);
              validationMessage = message;
              return null;
            },
            countries: const [
              Country(
                name: 'Egypt',
                flag: '🇪🇬',
                code: 'EG',
                dialCode: '20',
                nameTranslations: {'EG': 'Egypt'},
                minLength: 10,
                maxLength: 10,
              ),
            ],
          ),
        ),
        validationMessage != null
            ? Text(validationMessage ?? "", style: TextStyle(color: Colors.red))
            : const SizedBox.shrink(),
      ],
    );
  }
}
