import 'dart:ui';

import 'package:ekrilli_app/components/rating_widget.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../data/api/api.dart';
import '../utils/constants.dart';

class HouseWidget extends StatelessWidget {
  const HouseWidget({
    Key? key,
    required this.offer,
    this.margin,
    this.height,
    this.onTap,
  }) : super(key: key);
  final Offer offer;
  final EdgeInsets? margin;
  final double? height;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: margin ??
            EdgeInsets.symmetric(
              vertical: 10,
              horizontal: Get.width * 0.05,
            ),
        height: height ?? Get.height * 0.27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              offer.house?.pictures.first.picture ?? '',
            ),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 6,
              sigmaY: 6,
            ),
            child: Container(
              width: Get.width,
              height: (height ?? Get.height * 0.27) / 2,
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rooms(
                        rooms: offer.house?.kitchens ?? 1,
                        icon: FontAwesomeIcons.kitchenSet,
                      ),
                      rooms(
                        rooms: offer.house?.bathrooms ?? 1,
                        icon: FontAwesomeIcons.toilet,
                      ),
                      rooms(
                        rooms: offer.house?.bedrooms ?? 1,
                        icon: FontAwesomeIcons.bed,
                      ),
                    ],
                  ),
                  RatingWidget(
                    stars: offer.house?.stars ?? 0,
                    numReviews: offer.house?.numReviews ?? 0,
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
                        (offer.house!.location ?? '') +
                            ', ' +
                            (offer.house?.city?.name ?? ''),
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
      ),
    );
  }

  Row rooms({required int rooms, required IconData icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 15),
        Text(
          rooms.toString(),
          style: Get.theme.textTheme.headline6?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
