import 'package:ekrilli_app/models/city.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
