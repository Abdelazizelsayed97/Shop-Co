import 'package:e_commerce_web_app/features/authentication/ui/manager/cubit/otp/otp_cubit.dart';
import 'package:e_commerce_web_app/features/authentication/ui/widgets/pin_put_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/text_styles.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.email, required this.id});

  final String email;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCodeCubit(),
      child: OtpPageBody(email: email, id: id),
    );
  }
}

class OtpPageBody extends StatefulWidget {
  const OtpPageBody({super.key, required this.email, required this.id});
  final String email;
  final String id;

  @override
  State<OtpPageBody> createState() => _OtpPageBodyState();
}

class _OtpPageBodyState extends State<OtpPageBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCodeCubit, OtpCodeState>(
      listener: (context, state) {
        if (state.verifyEmailState.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email verified successfully")),
          );
        } else if (state.verifyEmailState.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.verifyEmailState.failureMessage ?? ""),
            ),
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Verify your account",
                style: TextStyles.boldFont(color: Colors.white, fontSize: 18),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/icons/Login-amico.png",
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  CodeVerificationField(
                    email: widget.id,
                    message: (message) {
                      if (message != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              message,
                              style: TextStyles.regularFont(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Text(
                    "Enter the otp sent to ${widget.email}",
                    style: TextStyles.regularFont(),
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
