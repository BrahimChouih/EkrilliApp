import 'dart:ui';

import 'package:ekrilli_app/components/city_widget.dart';
import 'package:ekrilli_app/components/custom_text_field.dart';
import 'package:ekrilli_app/components/empty_screen.dart';
import 'package:ekrilli_app/components/house_widget.dart';
import 'package:ekrilli_app/components/title_widget.dart';
import 'package:ekrilli_app/controllers/offers_controller.dart';
import 'package:ekrilli_app/data/api/api.dart';
import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeTap extends StatefulWidget {
  HomeTap({Key? key}) : super(key: key);

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  OfferController offerController = Get.put(OfferController());
  ScrollController offersScrollController = ScrollController();
  @override
  void initState() {
    offerController.getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.03),
              CustomTextField(
                hintText: 'Search',
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                borderColor: deepPrimaryColor,
                prefixIcon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: deepPrimaryColor,
                ),
              ),
              TitleWidget(
                title: 'Cities',
                margin: EdgeInsets.symmetric(
                  vertical: Get.height * 0.03,
                  horizontal: Get.width * 0.05,
                ),
              ),
              SizedBox(
                height: Get.height * 0.14,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, index) => CityWidget(
                    city: City(
                      name: 'Media',
                      picture:
                          '$api/media/Cities/Media_2022-03-29-105751.189979.jpg',
                      // picture:
                      //     '$api/media/Cities/Oran_2022-04-01-074238.694908.jpg',
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(
                      left: index == 0 ? Get.width * 0.05 : null,
                    ),
                    height: Get.height * 0.14,
                    width: Get.height * 0.15,
                  ),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              TitleWidget(
                title: 'Houses',
                margin: EdgeInsets.symmetric(
                  vertical: Get.height * 0.03,
                  horizontal: Get.width * 0.05,
                ),
              ),
              GetBuilder<OfferController>(
                builder: (_) => offerController.isEmpty
                    ? const Center(
                        child: EmptyScreen(
                          title: 'No Houses yet',
                          icon: FontAwesomeIcons.houseCircleExclamation,
                          isExpanded: false,
                        ),
                      )
                    : ListView.builder(
                        itemCount: offerController.offers.length,
                        controller: offersScrollController,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (_, index) => HouseWidget(
                          offer: offerController.offers.first..id = index,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
