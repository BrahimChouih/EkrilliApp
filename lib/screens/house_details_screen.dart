import 'package:ekrilli_app/components/pictures_slider.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/custom_app_bar.dart';

class HouseDetailsScreen extends StatelessWidget {
  HouseDetailsScreen({Key? key, required this.offer}) : super(key: key);
  Offer offer;
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
            PicturesSlider(
              pictures: offer.house?.pictures ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
