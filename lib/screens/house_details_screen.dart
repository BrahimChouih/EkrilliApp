import 'package:ekrilli_app/components/description_viewer.dart';
import 'package:ekrilli_app/components/pictures_slider.dart';
import 'package:ekrilli_app/components/rating_widget.dart';
import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/components/rooms_number_widget.dart';
import 'package:ekrilli_app/components/title_widget.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/custom_app_bar.dart';

class HouseDetailsScreen extends StatelessWidget {
  HouseDetailsScreen({Key? key, required this.offer}) : super(key: key);
  Offer offer;
  EdgeInsets margin = EdgeInsets.symmetric(
    horizontal: Get.width * 0.03,
    vertical: Get.height * 0.01,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'House',
              backButton: true,
              trailing: InkWell(
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.black54,
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.03,
                        vertical: Get.height * 0.02,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        offer.house?.title ?? '',
                        style: Get.theme.textTheme.headline5
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    PicturesSlider(
                      pictures: offer.house?.pictures ?? [],
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Container(
                      margin: margin,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              offer.house?.owner?.picture ?? '',
                            ),
                            radius: Get.width * 0.07,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            offer.house?.owner?.username ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          StarsWidget(
                            stars: offer.house?.stars ?? 0,
                            numReviews: offer.house?.numReviews ?? 1,
                            type: StarsWidgetType.digital,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: margin,
                      child: RoomsNumberWidget(
                        kitchens: offer.house?.kitchens ?? 1,
                        bathrooms: offer.house?.bathrooms ?? 1,
                        bedrooms: offer.house?.bedrooms ?? 1,
                        color: Colors.black54,
                        size: 25,
                        textStyle: Get.theme.textTheme.headline5,
                      ),
                    ),
                    TitleWidget(
                      title: 'Description:',
                      margin: margin.copyWith(
                        bottom: 0,
                        top: Get.height * 0.04,
                      ),
                      textStyle: Get.textTheme.headline6?.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: margin,
                      child: DescriptionViewer(
                          text: offer.house!.description ?? ''),
                    ),
                    RatingWidget(offer: offer),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
