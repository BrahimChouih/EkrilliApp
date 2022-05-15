import 'package:ekrilli_app/components/city_widget.dart';
import 'package:ekrilli_app/components/custom_text_field.dart';
import 'package:ekrilli_app/components/empty_screen.dart';
import 'package:ekrilli_app/components/house_widget.dart';
import 'package:ekrilli_app/components/title_widget.dart';
import 'package:ekrilli_app/controllers/house_controller.dart';
import 'package:ekrilli_app/controllers/offers_controller.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/data/api/api.dart';
import 'package:ekrilli_app/models/city.dart';
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
  HouseController houseController = Get.find<HouseController>();
  ScrollController offersScrollController = ScrollController();
  @override
  void initState() {
    if (offerController.isEmpty) {
      offerController.refreshData();
    }
    offersScrollController.addListener(() {
      if ((offersScrollController.position.maxScrollExtent * 0.9) <
          offersScrollController.position.pixels) {
        offerController.getNextPage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await offerController.refreshData();
            await houseController.getCities();
          },
          child: SingleChildScrollView(
            controller: offersScrollController,
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
                  child: GetBuilder<HouseController>(builder: (context) {
                    return ListView.builder(
                      itemCount: houseController.cities.length,
                      itemBuilder: (_, index) => CityWidget(
                        city: houseController.cities[index],
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10).copyWith(
                          left: index == 0 ? Get.width * 0.05 : null,
                        ),
                        height: Get.height * 0.14,
                        width: Get.height * 0.15,
                      ),
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                    );
                  }),
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
                      ? offerController.isLoading
                          ? HouseLoader()
                          : const Center(
                              child: EmptyScreen(
                                title: 'No Houses yet',
                                icon: FontAwesomeIcons.houseCircleExclamation,
                                isExpanded: false,
                              ),
                            )
                      : ListView.builder(
                          itemCount: offerController.offers.length + 1,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) => index !=
                                  offerController.offers.length
                              ? HouseWidget(
                                  offer: offerController.offers[index],
                                )
                              : offerController.isGetAllPages
                                  ? const SizedBox()
                                  : Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: const CircularProgressIndicator(),
                                    ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
