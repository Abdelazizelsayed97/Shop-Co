import 'package:e_commerce_web_app/core/helper/app_regex.dart';
import 'package:e_commerce_web_app/core/utils/complete_notifier.dart';
import 'package:e_commerce_web_app/core/utils/const_strings.dart';
import 'package:e_commerce_web_app/core/utils/local_hive_storage.dart';
import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:e_commerce_web_app/core/utils/shared_prefs.dart';
import 'package:e_commerce_web_app/core/utils/text_styles.dart';
import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/core/widgets/app_text_from.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/input/login_input.dart';
import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    isEnabled = CompleteCheckerNotifier(
      () =>
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty,
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage("lib/assets/icons/Login-amico.png"), context);
    super.didChangeDependencies();
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
          SharedPrefs.saveToShard(
            key: ConstStrings.token,
            value: state.loginState.data?.token ?? "",
          );
          SharedPrefs.saveToShard(
            key: ConstStrings.userId,
            value: state.loginState.data?.id ?? "",
          );
          var data = state.loginState.data;
          HiveStorageService().saveModel(
            boxName: "CurrentUser",
            key: "CurrentUser",
            model: data,
            toJson: (p0) => p0?.toJson() ?? {},
          );
          context.pushReplacement(
            "/",
            extra: context.read<AuthenticationCubit>(),
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
              automaticallyImplyLeading: false,
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
            validator: (value) {
              if (value == null) {
                return "E-mail is required";
              } else if (!AppRegex.validEmailRegex.hasMatch(value)) {
                return "Enter a valid email";
              }
              return null;
            },
            onChanged: (_) => isEnabled.checkIsDataCompleted(),
            height: 56.h,
            autoValidateMode: AutovalidateMode.onUserInteraction,
          ),
          SizedBox(height: 16.h),
          AppTextFormField(
            label: "Password",
            controller: _passwordController,

            validator: (value) {
              return passwordValidator(value ?? "");
            },
            onChanged: (_) => isEnabled.checkIsDataCompleted(),
            height: 56.h,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            suffixIcon: GestureDetector(
              onTap: () {
                if (_isObscure) {
                  _isObscure = false;
                } else {
                  _isObscure = true;
                }
                setState(() {});
              },
              child: Icon(
                _isObscure
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye,
              ),
            ),
            opsCureText: _isObscure,
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
    print(
      '_formKey.currentState!.validate() ${_formKey.currentState!.validate()}',
    );
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
            onPressed: () => context.pushNamed("/register"),
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
