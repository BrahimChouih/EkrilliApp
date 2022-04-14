import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(authController.currentUser?.toJson().toString() ?? ''),
          TextButton(
            onPressed: () async {
              await authController.signOut();
              Get.offAll(() => SplashScreen());
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
