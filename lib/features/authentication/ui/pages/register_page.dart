import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
  @override
  void initState() {
    _RegisterPageBodyState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20.h),
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
                              validator: (p0) {},
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Flexible(
                            child: AppTextFormField(
                              label: "Last Name",
                              controller: _lastNameController,
                              validator: (p0) {},
                            ),
                          ),
                        ],
                      ),
                      16.responsiveHeight(),
                      AppTextFormField(
                        label: "Phone",
                        controller: _phoneController,
                        validator: (p0) {},
                      ),
                      16.responsiveHeight(),
                      AppTextFormField(
                        label: "Email",
                        controller: _emailController,
                        validator: (p0) {},
                      ),
                      16.responsiveHeight(),
                      AppTextFormField(
                        label: "Password",
                        controller: _passwordController,
                        validator: (p0) {},
                      ),
                      16.responsiveHeight(),
                      AppTextFormField(
                        label: "Confirm Password",
                        controller: _confirmPasswordController,
                        validator: (p0) {},
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 16.h)),
                      AppPrimaryButton(
                        isLoading: false,
                        colors: [Colors.black, Colors.black87, Colors.black54],
                        child: Text(
                          "Register",
                          style: TextStyles.regularFont(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
}
