import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/authentication_cubit.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AuthenticationCubit(injector()),
      child: _LoginPage(),
    );
  }
}

class _LoginPage extends StatefulWidget {
  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _emailController;

  late TextEditingController _passwordController;
  late ValueNotifier<bool> isEnabled;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();


    isEnabled = ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.loginState.isSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
          );
        } else if (state.loginState.isFailure) {}
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Login",
                style: TextStyles.semiBoldFont(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24,
                horizontal:
                    constraints.maxWidth > 800
                        ? MediaQuery.of(context).size.width * 0.25
                        : constraints.maxWidth > 600
                        ? MediaQuery.of(context).size.width * 0.15
                        : 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/assets/images/logo.png",
                    width: constraints.maxWidth > 600 ? 400.w : 200.w,
                  ),
                  106.responsiveHeight(),
                  AppTextFormField(
                    label: "e-mail",
                    controller: _emailController,
                    validator: (value) {},
                    onChanged: (value) {},
                    height: 56.h,
                  ),
                  16.responsiveHeight(),
                  Padding(
                    padding: ResponsivePadding.symmetric(
                      vertical: 16,
                      horizontal: constraints.maxWidth > 600 ? 50 : 16,
                    ),
                    child: AppTextFormField(
                      label: "password",
                      controller: _passwordController,
                      validator: (value) {},
                      onChanged: (value) {},
                      height: 56.h,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ValueListenableBuilder(
                    valueListenable: isEnabled,
                    builder: (context, value, child) {
                      return AppPrimaryButton(
                        colors: [Colors.black, Colors.black87, Colors.black54],
                        isLoading: false,
                        onTap: () {
                          Get.to(() => HomePage(), popGesture: false);
                        },
                        child: Text(
                          "Login",
                          style: TextStyles.mediumFont(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
