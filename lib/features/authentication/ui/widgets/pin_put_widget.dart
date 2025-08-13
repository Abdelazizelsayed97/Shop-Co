import 'package:e_commerce_web_app/core/utils/local_hive_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../manager/cubit/otp/otp_cubit.dart';

class CodeVerificationField extends StatefulWidget {
  const CodeVerificationField({
    super.key,
    required this.message,
    required this.email,
  });

  final void Function(String message) message;
  final String email;

  @override
  State<CodeVerificationField> createState() => _CodeVerificationFieldState();
}

class _CodeVerificationFieldState extends State<CodeVerificationField> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCodeCubit, OtpCodeState>(
      listener: (context, state) {
        if (state.verifyEmailState.isSuccess) {
          HiveStorageService.service.saveModel(
            boxName: "CurrentUser",
            key: "CurrentUser",
            model: state.verifyEmailState.data,
            toJson: (p0) => p0?.toJson() ?? {},
          );
          context.goNamed("/");
        } else if (state.verifyResetPasswordState.isSuccess) {}
      },
      child: BlocBuilder<OtpCodeCubit, OtpCodeState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    // smsRetriever: smsRetriever,
                    controller: pinController,
                    focusNode: focusNode,
                    separatorBuilder: (index) => SizedBox(width: 8.w),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      print('completted ${pin}');
                      context.read<OtpCodeCubit>().verifyResetPassword(
                        widget.email,
                        pin,
                      );
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    defaultPinTheme: PinTheme(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              state.verifyEmailState.isSuccess ||
                                      state.verifyResetPasswordState.isSuccess
                                  ? Colors.green
                                  : state.verifyEmailState.isFailure ||
                                      state.verifyResetPasswordState.isFailure
                                  ? Colors.red
                                  : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    useNativeKeyboard: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
