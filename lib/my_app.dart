import 'package:e_commerce_web_app/core/utils/responsive_by_media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/authentication/ui/pages/login_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void didChangeDependencies() {
       SaveContext.instance.setBuildContext(context);
    precacheImage(AssetImage("lib/assets/images/group.png"), context);
    precacheImage(AssetImage("lib/assets/images/Group_mobile_view.png"), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        builder: (context, child) {
          return LoginPage();
        },
      ),
    );
  }
}
