import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/custom_bottom_navigation_bar.dart';
import '../controllers/nav_bar_controller.dart';

class HomeScreen extends StatelessWidget {
  NavBarController navBarController = Get.put(NavBarController());

  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavBarController>(
        builder: (_) => navBarController.currentPage,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
