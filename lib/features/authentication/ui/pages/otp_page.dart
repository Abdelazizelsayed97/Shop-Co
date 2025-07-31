import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify your account",
          style: TextStyles.boldFont(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Center(child: Text("OTP Page")),
    );
  }
}
