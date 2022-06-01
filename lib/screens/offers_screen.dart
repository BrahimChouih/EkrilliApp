import 'package:ekrilli_app/components/house_widget.dart';
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
import '../components/offer_item.dart';
import '../models/offer.dart';
import '../utils/constants.dart';

class OffersScreen extends StatefulWidget {
  OffersScreen({Key? key, required this.house}) : super(key: key);
  House house;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  OfferController offerController = Get.find<OfferController>();

  @override
  void initState() {
    offerController.isGettingOfferByHouse = true;
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(const Duration(milliseconds: 300));
        offerController.getoffersByHouse(widget.house.id!);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    offerController.offersByHouse = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.notesMedical,
          color: Colors.white,
        ),
        onPressed: () {
          Offer? offer;
          try {
            offer = offerController.offerWithPublishStatus;
          } catch (e) {
            print(e);
          }

          Get.to(
            () => CreateOfferScreen(
              house: widget.house,
              offer: offer,
              isUpdate: offer != null,
            ),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'My Offers',
              backButton: true,
            ),
            SizedBox(height: Get.height * 0.01),
            Expanded(
              child: GetBuilder<OfferController>(
                  id: offerController.offersByHouseId,
                  builder: (context) {
                    return offerController.isGettingOfferByHouse
                        ? const OfferItemLoader()
                        : Column(
                            children: [
                              offerController.offersByHouse.isEmpty
                                  ? const EmptyScreen(
                                      title: 'There are not any offers yet',
                                      icon: FontAwesomeIcons.moneyCheckDollar,
                                    )
                                  : Expanded(
                                      child: Column(
                                        children: [
                                          const SwipeHelp(
                                              text: 'swipe on an item to edit'),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: offerController
                                                  .offersByHouse.length,
                                              shrinkWrap: true,
                                              primary: false,
                                              itemBuilder: (_, index) =>
                                                  OfferItem(
                                                offer: offerController
                                                    .offersByHouse[index],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
