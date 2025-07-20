import 'package:e_commerce_web_app/core/helper/app_regex.dart';
import 'package:e_commerce_web_app/core/utils/complete_notifier.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';
import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/authentication_cubit.dart';
import 'package:e_commerce_web_app/features/authentication/ui/pages/register_page.dart';
import 'package:e_commerce_web_app/features/home/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: const _LoginPage(),
    );
  }
}

class _LoginPage extends StatefulWidget {
  const _LoginPage();

  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final CompleteCheckerNotifier isEnabled;
  final _formKey = GlobalKey<FormState>();
  late GifController _gifController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _gifController = GifController(vsync: this);
    isEnabled = CompleteCheckerNotifier(
      () =>
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    isEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.loginState.isSuccess) {
          Get.to(
            () => HomePage(
              userInfoEntity: state.loginState.data ?? UserInfoEntity(),
            ),
            popGesture: false,
          );
        } else if (state.loginState.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.loginState.failureMessage ?? "Unknown error"),
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
              title: Text(
                "Login",
                style: TextStyles.semiBoldFont(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
            ),
            body: Stack(
              children: [
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding,
                    vertical: 20.h,
                  ),
                  child: _buildLoginForm(constraints),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginForm(BoxConstraints constraints) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "lib/assets/icons/Login-amico.png",
            width:
                constraints.maxWidth > 800
                    ? constraints.maxWidth * .25
                    : constraints.maxWidth * .5,
            fit: BoxFit.contain,
          ),
          106.responsiveHeight(),
          AppTextFormField(
            label: "E-mail",
            controller: _emailController,
            validator: (value) => null,
            onChanged: (_) => isEnabled.checkIsDataCompleted(),
            height: 56.h,
          ),
          16.responsiveHeight(),
          AppTextFormField(
            label: "Password",
            controller: _passwordController,
            validator: (value) {
              passwordValidator(value ?? "");
            },
            onChanged: (_) => isEnabled.checkIsDataCompleted(),
            height: 56.h,
            autoValidateMode: AutovalidateMode.onUserInteraction,
          ),
          SizedBox(height: 16.h),
          ValueListenableBuilder<bool>(
            valueListenable: isEnabled,
            builder: (context, value, _) {
              return AppPrimaryButton(
                colors:
                    value
                        ? [Colors.black, Colors.black87, Colors.black54]
                        : [Colors.grey, Colors.grey.shade300],
                isLoading: false,
                onTap: value ? _loginPress : null,
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
          _buildRegisterSection(),
        ],
      ),
    );
  }

  void _loginPress() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationCubit>().login(
        LoginInput(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  _buildRegisterSection() {
    return Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyles.regularFont(
              color: Colors.grey.shade600,
              fontSize: 16.sp,
            ),
          ),
          TextButton(
            onPressed: () => Get.to(() => RegisterPage()),
            child: Text(
              "Register",
              style: TextStyles.semiBoldFont(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
