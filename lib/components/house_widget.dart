import 'dart:ui';

import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/components/rooms_number_widget.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/screens/house_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../data/api/api.dart';
import '../utils/constants.dart';

class HouseWidget extends StatelessWidget {
  const HouseWidget({
    Key? key,
    this.offer,
    this.house,
    this.margin,
    this.height,
    this.onTap,
  }) : super(key: key);
  final Offer? offer;
  final House? house;
  final Function()? onTap;
  final EdgeInsets? margin;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap ??
          () {
            if (offer != null) {
              Get.to(
                () => HouseDetailsScreen(
                  offer: offer!,
                ),
              );
            }
          },
      child: Container(
        margin: margin ??
            EdgeInsets.symmetric(
              vertical: 10,
              horizontal: Get.width * 0.05,
            ),
        height: height ?? Get.height * 0.27,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: NetworkImage(
          //     offer.house?.pictures.first.picture ?? '',
          //   ),
          // ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              width: Get.width * 0.9,
              height: height ?? Get.height * 0.27,
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Image.network(
                  (offer?.house ?? house)?.pictures.first.picture ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 6,
                  sigmaY: 6,
                ),
                child: Container(
                  width: Get.width,
                  // height: (height ?? Get.height * 0.27) * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        deepPrimaryColor.withOpacity(0.3),
                        deepPrimaryColor.withOpacity(0.1),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RoomsNumberWidget(
                        kitchens: (offer?.house ?? house)?.kitchens ?? 1,
                        bathrooms: (offer?.house ?? house)?.bathrooms ?? 1,
                        bedrooms: (offer?.house ?? house)?.bedrooms ?? 1,
                      ),
                      StarsWidget(
                        stars: (offer?.house ?? house)?.stars ?? 0,
                        numReviews: (offer?.house ?? house)?.numReviews ?? 0,
                      ),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.locationDot,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            ((offer?.house ?? house)!.location ?? '') +
                                ', ' +
                                ((offer?.house ?? house)?.city?.name ?? ''),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
