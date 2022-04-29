import 'package:ekrilli_app/components/rating_item.dart';
import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/controllers/rating_controller.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class RatingWidget extends StatelessWidget {
  RatingWidget({
    Key? key,
    required this.offer,
  }) : super(key: key);

  final Offer offer;
  RatingController ratingController = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (_, index) => RatingItem(
        rating: ratingController.ratings.first,
      ),
    );
  }
}
