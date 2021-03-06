import 'dart:ui';

import 'package:ekrilli_app/components/blur_widget.dart';
import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/components/rooms_number_widget.dart';
import 'package:ekrilli_app/models/house.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/screens/house_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

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
                child: (offer?.house ?? house)!.pictures.isNotEmpty
                    ? Image.network(
                        (offer?.house ?? house)!.pictures.first.picture,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: deepPrimaryColor.withOpacity(0.1),
                        child: SvgPicture.asset(
                          'assets/vectors/house.svg',
                        ),
                      ),
              ),
            ),
            BlurWidget(
              borderRadius: borderRadius,
              child: Container(
                width: Get.width * 0.9,
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
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StarsWidget(
                              stars: (offer?.house ?? house)?.stars ?? 0,
                              numReviews:
                                  (offer?.house ?? house)?.numReviews ?? 0,
                            ),
                            Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                (offer?.house ?? house)!.municipality != null
                                    ? Text(
                                        ((offer?.house ?? house)!
                                                    .municipality
                                                    ?.name ??
                                                '') +
                                            ', ' +
                                            ((offer?.house ?? house)
                                                    ?.municipality
                                                    ?.city
                                                    ?.name ??
                                                ''),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        offer?.pricePerDay != null
                            ? Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      offer!.pricePerDay.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'DA/Day',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
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

class HouseLoader extends StatelessWidget {
  const HouseLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SkeletonLoader(
        baseColor: deepPrimaryColor.withOpacity(0.1),
        builder: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: Get.width * 0.05,
          ),
          height: Get.height * 0.27,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
        ),
        items: 4,
        period: const Duration(seconds: 2),
        highlightColor: primaryColor.withOpacity(0.6),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
