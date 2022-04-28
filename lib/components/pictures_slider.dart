import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekrilli_app/components/full_screen_pictures_slider.dart';
import 'package:ekrilli_app/models/picture.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PicturesSlider extends StatelessWidget {
  PicturesSlider({
    Key? key,
    required this.pictures,
  }) : super(key: key);
  List<Picture> pictures;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => FullscreenPicturesSlider(pictures),
        // transitionDuration: const Duration(milliseconds: 200),
        opaque: false,
      ),
      child: Stack(
        children: [
          Container(
            height: picturesHeight,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
          Hero(
            tag: 'PictureSlider',
            child: CarouselSlider.builder(
              itemCount: pictures.length,
              itemBuilder: (_, index, index2) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      pictures[index].picture!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              options: CarouselOptions(
                autoPlay: pictures.length > 1,
                height: picturesHeight,
                enableInfiniteScroll: pictures.length > 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
