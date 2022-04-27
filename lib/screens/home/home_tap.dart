import 'dart:ui';

import 'package:ekrilli_app/components/city_widget.dart';
import 'package:ekrilli_app/components/custom_text_field.dart';
import 'package:ekrilli_app/components/house_widget.dart';
import 'package:ekrilli_app/components/title_widget.dart';
import 'package:ekrilli_app/data/api/api.dart';
import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({Key? key}) : super(key: key);

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
                prefixIcon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: primaryColor,
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
                      name: 'Oran',
                      picture:
                          '$api/media/Cities/Oran_2022-04-01-074238.694908.jpg',
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
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (_, index) => HouseWidget(
                  offer: Offer(
                    house: House(
                      title: 'Come to titree',
                      location: '3ème Boulevard Péripherique',
                      city: City(name: 'Oran'),
                      rooms: 4,
                      kitchens: 1,
                      bathrooms: 1,
                      bedrooms: 1,
                      stars: 23,
                      numReviews: 5,
                      pictures: [
                        Picture(
                          picture:
                              '$api/media/houses/Come_to_Titree_2022-03-29-105836.813969.jpg',
                        ),
                      ],
                    ),
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
