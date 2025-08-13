import 'package:e_commerce_web_app/core/helper/app_regex.dart';
import 'package:e_commerce_web_app/core/utils/app_colors.dart';
import 'package:e_commerce_web_app/core/utils/complete_notifier.dart';
import 'package:e_commerce_web_app/core/utils/phone_text_field.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/register_input.dart';
import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/phone_number.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterPageBody();
  }
}

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late CompleteCheckerNotifier isEnabled;
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  late AuthenticationCubit cubit;
  @override
  void initState() {
    isEnabled = CompleteCheckerNotifier(
      () =>
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty,
    );
    _RegisterPageBodyState();
    cubit = context.read<AuthenticationCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    isEnabled.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.signUpState.isSuccess) {
          print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
          context.goNamed(
            "/otp",
            extra: _emailController.text,
            pathParameters: {"id": state.signUpState.data ?? ""},
          );
        }
        if (state.signUpState.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.signUpState.failureMessage ?? "Unknown error",
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final padding =
              constraints.maxWidth > 800
                  ? MediaQuery.of(context).size.width * 0.25
                  : constraints.maxWidth > 600
                  ? MediaQuery.of(context).size.width * 0.15
                  : 16.0;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: null,
              title: Text(
                "Register",
                style: TextStyles.boldFont(fontSize: 22, color: Colors.white),
              ),
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: 20.h,
              ),
              child: Center(
                heightFactor: 1,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  child: Container(
                    width: 680.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 32.h,
                      horizontal: 28.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.black),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "lib/assets/icons/Sign up-amico.svg",
                          width:
                              constraints.maxWidth > 800
                                  ? constraints.maxWidth * .23
                                  : constraints.maxWidth * .4,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Text(
                            "Register",
                            style: TextStyles.boldFont(fontSize: 24),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: AppTextFormField(
                                label: "First Name",
                                controller: _firstNameController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'First name is required';
                                  } else if (value.length < 2) {
                                    return 'First name must be at least 2 characters';
                                  }
                                  return null;
                                },
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged:
                                    (_) => isEnabled.checkIsDataCompleted(),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Flexible(
                              child: AppTextFormField(
                                label: "Last Name",
                                controller: _lastNameController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Last name is required';
                                  } else if (value.length < 2) {
                                    return 'Last name must be at least 2 characters';
                                  }
                                  return null;
                                },
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged:
                                    (_) => isEnabled.checkIsDataCompleted(),
                              ),
                            ),
                          ],
                        ),
                        16.responsiveHeight(),
                        PhoneTextField(
                          controller: _phoneController,
                          onChanged: (_) => isEnabled.checkIsDataCompleted(),
                          validation: (PhoneNumber? phoneNumber) {
                            if (phoneNumber == null ||
                                phoneNumber.number.trim().isEmpty) {
                              return 'Phone number is required';
                            }
                            return null;
                          },
                        ),
                        16.responsiveHeight(),
                        AppTextFormField(
                          label: "Email",
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            } else if (!AppRegex.validEmailRegex.hasMatch(
                              value,
                            )) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (_) => isEnabled.checkIsDataCompleted(),
                        ),
                        16.responsiveHeight(),
                        AppTextFormField(
                          label: "Password",
                          controller: _passwordController,
                          validator: (p0) {
                            return passwordValidator(_passwordController.text);
                          },
                          opsCureText: isHiddenPassword,
                          onChanged: (_) => isEnabled.checkIsDataCompleted(),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (isHiddenPassword) {
                                setState(() {
                                  isHiddenPassword = false;
                                });
                              } else {
                                setState(() {
                                  isHiddenPassword = true;
                                });
                              }
                            },
                            child:
                                isHiddenPassword
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.remove_red_eye_outlined),
                          ),
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          message: passwordValidator(_passwordController.text),
                        ),
                        16.responsiveHeight(),
                        AppTextFormField(
                          label: "Confirm Password",
                          controller: _confirmPasswordController,
                          autoValidateMode: AutovalidateMode.always,
                          validator: (p0) {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              return "Password doesn't match";
                            }
                            return null;
                          },
                          onChanged: (_) => isEnabled.checkIsDataCompleted(),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (isHiddenConfirmPassword) {
                                setState(() {
                                  isHiddenConfirmPassword = false;
                                });
                              } else {
                                setState(() {
                                  isHiddenConfirmPassword = true;
                                });
                              }
                            },
                            child:
                                isHiddenConfirmPassword
                                    ? Icon(Icons.visibility_off_outlined)
                                    : Icon(Icons.remove_red_eye_outlined),
                          ),
                          opsCureText: isHiddenConfirmPassword,
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 16.h)),
                        ValueListenableBuilder(
                          builder: (context, value, child) {
                            return AppPrimaryButton(
                              onTap:
                                  value
                                      ? () {
                                        setState(() {});
                                        _registerPress();
                                      }
                                      : null,
                              isLoading: false,
                              colors:
                                  value
                                      ? [
                                        Colors.black,
                                        Colors.black87,
                                        Colors.black54,
                                      ]
                                      : AppColors.disableGradientList,
                              child: Text(
                                "Register",
                                style: TextStyles.regularFont(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          valueListenable: isEnabled,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _RegisterPageBodyState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }
  void _registerPress() {
    print('------ ${_formKey.currentState!.validate()}');
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationCubit>().signUpFunction(
        RegisterInput(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
