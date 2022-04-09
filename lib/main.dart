import 'package:ekrilli_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

void main() {
  // Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    return GetMaterialApp(
      home: LoginScreen(),
    );
  }
}
