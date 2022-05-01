import 'dart:ui';

import 'package:ekrilli_app/components/custom_app_bar.dart';
import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/screens/splash_screen.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../components/profile_tap_item.dart';
import '../../components/profile_tap_tile.dart';

class ProfileTap extends StatelessWidget {
  ProfileTap({Key? key}) : super(key: key);
  // AuthController authController = Get.find<AuthController>();
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/vectors/profile.svg',
              color: Colors.white.withOpacity(0.7),
              colorBlendMode: BlendMode.dstATop,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  section(
                    child: userInfo(),
                    width: Get.width,
                  ),
                  const Spacer(),
                  section(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileTapItem(
                          icon: FontAwesomeIcons.house,
                          title: 'My houses',
                          onTap: () {},
                        ),
                        ProfileTapItem(
                          icon: FontAwesomeIcons.clockRotateLeft,
                          title: 'History',
                          onTap: () {},
                        ),
                        ProfileTapItem(
                          icon: FontAwesomeIcons.house,
                          title: 'Rented',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  section(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.02,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfielTapTile(
                          title: 'Settings',
                          icon: FontAwesomeIcons.gears,
                          onTap: () {},
                        ),
                        ProfielTapTile(
                          title: 'Privacy Policy',
                          icon: FontAwesomeIcons.shield,
                          onTap: () {},
                        ),
                        ProfielTapTile(
                          title: 'About Us',
                          icon: FontAwesomeIcons.circleInfo,
                          onTap: () {},
                        ),
                        SubmitButton(
                          text: 'Sign Out',
                          color: deepPrimaryColor.withOpacity(0.2),
                          margin: EdgeInsets.symmetric(vertical: 15),
                          onTap: () async {
                            await authController.signOut();
                            Get.offAll(SplashScreen());
                          },
                        ),
                        SizedBox(height: Get.height * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column userInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: deepPrimaryColor.withOpacity(0.2),
          backgroundImage: authController.currentUser?.picture != null
              ? NetworkImage(
                  authController.currentUser?.picture ?? '',
                )
              : null,
          child: authController.currentUser?.picture == null
              ? const Icon(
                  FontAwesomeIcons.userLarge,
                  color: Colors.white,
                  size: 35,
                )
              : null,
          radius: Get.width * 0.1,
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          authController.currentUser?.username?.toUpperCase() ?? '',
          style: Get.textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          authController.currentUser?.userType?.toUpperCase() ?? '',
        ),
      ],
    );
  }

  Widget section({
    required Widget child,
    EdgeInsets? padding,
    double? width,
    double? height,
  }) =>
      ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            width: width,
            height: height,
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05,
                  vertical: 15,
                ),
            decoration: BoxDecoration(
              color: deepPrimaryColor.withOpacity(0.1),
              borderRadius: borderRadius,
            ),
            child: child,
          ),
        ),
      );
}
