import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:ekrilli_app/controllers/house_controller.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/screens/authentication_screen.dart';
import 'package:ekrilli_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/favorite_controller.dart';
import '../utils/constants.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  bool isFirstTime = true;
  void goToNextScreen() async {
    // await Future.delayed(const Duration(seconds: 3));
    AuthController authController = Get.find<AuthController>();
    HouseController houseController = Get.put(HouseController());
    // FavoriteController favoriteController = Get.put(FavoriteController());
    // MessagesController messagesController = Get.put(MessagesController());
    Get.lazyPut(() => FavoriteController(), fenix: true);
    Get.lazyPut(() => MessagesController(), fenix: true);

    try {
      await authController.initData();
      await houseController.getCities();
      if (authController.isLogin) {
        await Get.offAll(
          () => HomeScreen(),
        );
      } else {
        Get.offAll(
          () => AuthenticationScreen(),
        );
      }
    } on DioError catch (e) {
      String message = e.message.toString();
      if (e.message == 'Http status error [401]') {
        message = e.message;
        authController.signOut();
      } else if (e.error.runtimeType == SocketException) {
        message = (e.error as SocketException).message;
      }

      Get.defaultDialog(
        title: 'Error',
        content: Text(
          'Error type: ' + message,
        ),
        confirm: TextButton(
          onPressed: () async {
            Get.back();
            await Future.delayed(const Duration(seconds: 1));
            goToNextScreen();
          },
          child: const Text('Rety'),
        ),
      );
    }
  }

  final String introText = 'Ekrilli app\nRent a house now';
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AuthController>(() => AuthController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.08,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Get.height * 0.5,
              child: SvgPicture.asset(
                'assets/vectors/splash.svg',
              ),
            ),
            SizedBox(
              height: 80,
              width: Get.width,
              child: DefaultTextStyle(
                style: Get.theme.textTheme.headline4?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      introText,
                      speed: Duration(
                        milliseconds: 2000 ~/ introText.length,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  pause: const Duration(seconds: 2),
                  onNextBeforePause: (i, b) {
                    if (isFirstTime) {
                      goToNextScreen();
                      isFirstTime = false;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
