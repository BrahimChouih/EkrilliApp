import 'package:ekrilli_app/controllers/house_controller.dart';
import 'package:ekrilli_app/screens/create_house_screen.dart';
import 'package:ekrilli_app/screens/offers_screen.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/custom_app_bar.dart';
import '../components/empty_screen.dart';
import '../components/house_widget.dart';

class MyHousesScreen extends StatelessWidget {
  MyHousesScreen({Key? key}) : super(key: key);
  HouseController houseController = Get.put(HouseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.houseMedical,
          color: Colors.white,
        ),
        onPressed: () => Get.to(() => CreateHouseScreen()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'My Houses',
              backButton: true,
            ),
            SizedBox(height: Get.height * 0.01),
            houseController.isEmpty
                ? const EmptyScreen(
                    title: 'You don\'t create any house yet',
                    icon: FontAwesomeIcons.houseCircleXmark,
                  )
                : Expanded(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) => Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02,
                              vertical: 10,
                            ),
                            child: Dismissible(
                              key: ObjectKey(index),
                              background:
                                  backgroundSwipping(Alignment.centerLeft),
                              secondaryBackground:
                                  backgroundSwipping(Alignment.centerRight),
                              onDismissed: (DismissDirection dismissDirection) {
                                if (dismissDirection ==
                                    DismissDirection.startToEnd) {
                                  print('remove');
                                }
                              },
                              confirmDismiss:
                                  (DismissDirection dismissDirection) async {
                                if (dismissDirection ==
                                    DismissDirection.startToEnd) {
                                  print('remove');
                                  bool confirmed = false;
                                  await Get.defaultDialog(
                                    title: 'Wait',
                                    content: const Text(
                                      'Do you want to delete this house ?',
                                    ),
                                    onCancel: () {
                                      confirmed = false;
                                      // Get.back();
                                    },
                                    onConfirm: () {
                                      confirmed = true;
                                      Get.back();
                                    },
                                    confirmTextColor: Colors.white,
                                  );
                                  return confirmed;
                                } else {
                                  print('edit');
                                  return false;
                                }
                              },
                              child: HouseWidget(
                                margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.03,
                                ),
                                house: houseController.houses.first..id = index,
                                onTap: () {
                                  Get.to(() => OffersScreen());
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          child: ClipRRect(
                            borderRadius: borderRadius,
                            child: BackdropFilter(
                              filter: blurEffect,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: borderRadius,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/swipe.svg',
                                      color: deepPrimaryColor,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'swipe on an item to delete or edit',
                                      style: TextStyle(
                                        color: deepPrimaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

  Widget backgroundSwipping(AlignmentGeometry alignment) => Container(
        decoration: BoxDecoration(
          color: alignment == Alignment.centerLeft ? Colors.red : primaryColor,
          borderRadius: borderRadius,
        ),
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Icon(
          alignment == Alignment.centerLeft
              ? FontAwesomeIcons.trashCan
              : FontAwesomeIcons.penToSquare,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      );
}
