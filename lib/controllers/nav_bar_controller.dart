import 'package:ekrilli_app/screens/home/favorite_tap.dart';
import 'package:ekrilli_app/screens/home/chat_tap.dart';
import 'package:ekrilli_app/screens/home/profile_tap.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../screens/home/home_tap.dart';

class NavBarController extends GetxController {
  List<Widget> pages = [
    HomeTap(),
    ChatTap(),
    FavoriteTap(),
    ProfileTap(),
  ];

  int currentPageIndex = 0;

  Widget get currentPage => pages[currentPageIndex];

  void onChange(int index) {
    currentPageIndex = index;
    update();
  }
}
