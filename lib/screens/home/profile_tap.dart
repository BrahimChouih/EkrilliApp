import 'dart:ui';
import 'package:ekrilli_app/components/custom_app_bar.dart';
import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/screens/my_houses_screen.dart';
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
            // Positioned(
            //   left: -Get.width * 0.1,
            //   child: SvgPicture.asset(
            //     'assets/vectors/profile.svg',
            //     // 'assets/vectors/profile2.svg',
            //     // color: Colors.white.withOpacity(0.7),
            //     // colorBlendMode: BlendMode.dstATop,
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        section(
                          margin: EdgeInsets.only(top: Get.height * 0.01),
                          child: userInfo(),
                          width: Get.width,
                        ),
                        const Spacer(),
                        section(
                          margin: EdgeInsets.only(top: Get.height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfileTapItem(
                                icon: FontAwesomeIcons.house,
                                title: 'My houses',
                                onTap: () => Get.to(() => MyHousesScreen()),
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
                        section(
                          margin: EdgeInsets.only(top: Get.height * 0.01),
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02,
                            vertical: Get.height * 0.02,
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
                                textColor: Colors.black.withOpacity(0.75),
                                fontWeight: FontWeight.bold,
                                color: deepPrimaryColor.withOpacity(0.2),
                                margin: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.02,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.1,
                                  vertical: Get.height * 0.02,
                                ),
                                onTap: () async {
                                  await authController.signOut();
                                  Get.offAll(SplashScreen());
                                },
                              ),
                            ],
                          ),
                        ),
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
          backgroundColor: Colors.transparent,
          backgroundImage: authController.currentUser?.picture != null
              ? NetworkImage(
                  authController.currentUser?.picture ?? '',
                )
              : null,
          child: authController.currentUser?.picture == null
              ? SvgPicture.asset(
                  'assets/vectors/person.svg',
                )
              : null,
          radius: Get.width * 0.1,
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          authController.currentUser?.username?.toUpperCase() ?? '',
          style: Get.textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        Text(
          authController.currentUser?.userType?.toUpperCase() ?? '',
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  Widget section({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? width,
    double? height,
  }) =>
      ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            width: width,
            height: height,
            margin: margin,
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05,
                  vertical: Get.height * 0.02,
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
