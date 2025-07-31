import 'package:e_commerce_web_app/core/di/app_di.dart';
import 'package:e_commerce_web_app/firebase_options.dart';
import 'package:e_commerce_web_app/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/utils/local_hive_storage.dart';
import 'core/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDi().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefs.sharedInitialization();
  await HiveStorageService.init();
  usePathUrlStrategy();
  // router.goNamed("/");
  runApp(const MyApp());
}
