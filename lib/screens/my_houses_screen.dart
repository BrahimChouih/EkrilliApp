import 'package:ekrilli_app/components/swipe_help.dart';
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
import '../controllers/pagination_controller.dart';

class MyHousesScreen extends StatefulWidget {
  MyHousesScreen({Key? key}) : super(key: key);

  @override
  State<MyHousesScreen> createState() => _MyHousesScreenState();
}

class _MyHousesScreenState extends State<MyHousesScreen> {
  HouseController houseController = Get.put(HouseController());
  ScrollController myHousesScrollController = ScrollController();
  Parameters? parameters;

  @override
  void initState() {
    parameters = Parameters(myHouses: true);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await houseController.refreshData(parameters: parameters);
      await houseController.getNextPage(parameters: parameters);
    });

    myHousesScrollController.addListener(() {
      if ((myHousesScrollController.position.maxScrollExtent * 0.8) <
          myHousesScrollController.position.pixels) {
        houseController.getNextPage(parameters: parameters);
      }
    });

    super.initState();
  }

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
            Expanded(
              child: GetBuilder<HouseController>(
                builder: (context) {
                  return houseController.isEmpty
                      ? houseController.isLoading
                          ? const HouseLoader()
                          : const Center(
                              child: EmptyScreen(
                                title: 'You don\'t create any house yet',
                                icon: FontAwesomeIcons.houseCircleXmark,
                                isExpanded: false,
                              ),
                            )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await houseController.refreshData(
                                parameters: parameters);
                          },
                          child: SizedBox(
                            height: double.infinity,
                            child: ListView.builder(
                              itemCount: houseController.myHouses.length + 1,
                              shrinkWrap: true,
                              primary: false,
                              controller: myHousesScrollController,
                              itemBuilder: (_, index) => index !=
                                      houseController.myHouses.length
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.02,
                                        vertical: 10,
                                      ),
                                      child: Dismissible(
                                        key: ObjectKey(index),
                                        background: backgroundSwipping(
                                            Alignment.centerLeft),
                                        secondaryBackground: backgroundSwipping(
                                            Alignment.centerRight),
                                        onDismissed: (DismissDirection
                                            dismissDirection) {
                                          if (dismissDirection ==
                                              DismissDirection.startToEnd) {
                                            print('remove');
                                          }
                                        },
                                        confirmDismiss: (DismissDirection
                                            dismissDirection) async {
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
                                          house:
                                              houseController.myHouses[index],
                                          onTap: () {
                                            Get.to(
                                              () => OffersScreen(
                                                house: houseController
                                                    .myHouses[index],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : houseController.isGetAllPages
                                      ? const SizedBox()
                                      : Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                            ),
                          ),
                        );
                },
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
