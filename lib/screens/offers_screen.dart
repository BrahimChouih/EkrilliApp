import 'package:ekrilli_app/components/swipe_help.dart';
import 'package:ekrilli_app/controllers/offers_controller.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/screens/create_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/custom_app_bar.dart';
import '../components/empty_screen.dart';
import '../utils/constants.dart';

class OffersScreen extends StatelessWidget {
  OffersScreen({Key? key, required this.house}) : super(key: key);
  House house;
  OfferController offerController = Get.find<OfferController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.notesMedical,
          color: Colors.white,
        ),
        onPressed: () => Get.to(() => CreateOfferScreen(
              house: house,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'My Offers',
              backButton: true,
            ),
            SizedBox(height: Get.height * 0.01),
            offerController.isEmpty
                ? const EmptyScreen(
                    title: 'There are not any offers yet',
                    icon: FontAwesomeIcons.moneyCheckDollar,
                  )
                : Expanded(
                    child: Column(
                      children: [
                        const SwipeHelp(text: 'swipe on an item to edit'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: borderRadius,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.5),
                                    blurRadius: 8,
                                    spreadRadius: -3,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Dismissible(
                                key: ObjectKey(index),
                                background:
                                    backgroundSwipping(Alignment.centerLeft),
                                secondaryBackground:
                                    backgroundSwipping(Alignment.centerRight),
                                onDismissed:
                                    (DismissDirection dismissDirection) {
                                  if (dismissDirection ==
                                      DismissDirection.startToEnd) {
                                    print('remove');
                                  }
                                },
                                confirmDismiss: (dismissDirection) async {
                                  print('edit');
                                  return false;
                                },
                                child: ListTile(
                                  title: Text(
                                    offerController.offers.first.status ?? '',
                                  ),
                                  trailing: Text(
                                    offerController.offers.first.pricePerDay
                                            .toString() +
                                        ' DA',
                                  ),
                                  subtitle: Text(offerController
                                          .offers.first.user?.username ??
                                      ''),
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
          color: primaryColor,
          borderRadius: borderRadius,
        ),
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Icon(
          FontAwesomeIcons.penToSquare,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      );
}
