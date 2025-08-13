import 'package:e_commerce_web_app/features/home/ui/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBarWidget(constraints: constraints, globalKey: globalKey),
          body: Row(
            children: [
              Column(
                children: [
                  Text("order page "),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Bone.button(type: BoneButtonType.text, words: 10),
                  ),
                ],
              ),
              Container(decoration: BoxDecoration(color: Colors.red)),
            ],
          ),
        );
      },
    );
  }
}
