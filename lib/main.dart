import 'package:ekrilli_app/screens/home_screen.dart';
import 'package:ekrilli_app/screens/my_houses_screen.dart';
import 'package:ekrilli_app/screens/splash_screen.dart';
import 'package:ekrilli_app/themes/primary_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helpers/notification_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: primaryTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: HomeScreen(),
      // home: MyHousesScreen(),
    );
  }
}
