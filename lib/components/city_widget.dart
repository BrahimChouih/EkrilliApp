import 'package:ekrilli_app/controllers/offers_controller.dart';
import 'package:ekrilli_app/models/city.dart';
import 'package:ekrilli_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CityWidget extends StatelessWidget {
  CityWidget({
    Key? key,
    required this.city,
    this.height,
    this.width,
    this.margin,
  }) : super(key: key);
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final City city;
  OfferController offerController = Get.find<OfferController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => CityScreen(city: city),
        transition: Transition.upToDown,
      ),
      child: Hero(
        tag: city.id!,
        child: Container(
          height: height,
          width: width,
          margin: margin ?? const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.black,
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.7,
              image: NetworkImage(
                city.picture!,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            city.name!,
            style: Get.theme.textTheme.headline6?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
