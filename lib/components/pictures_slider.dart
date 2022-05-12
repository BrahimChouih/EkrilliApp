import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekrilli_app/components/full_screen_pictures_slider.dart';
import 'package:ekrilli_app/models/picture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PicturesSlider extends StatelessWidget {
  PicturesSlider({
    Key? key,
    required this.pictures,
  }) : super(key: key);
  List<Picture> pictures;
  RxInt currentIndex = 0.obs;
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
              itemBuilder: (_, index, index2) => Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: index != currentIndex.value ? 10 : 0,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: pictures[index].isUrl
                        ? DecorationImage(
                            image: NetworkImage(
                              pictures[index].picture,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !pictures[index].isUrl
                      ? Container(
                          color: Colors.white,
                          child: SvgPicture.asset(pictures[index].picture))
                      : SizedBox(),
                ),
              ),
              options: CarouselOptions(
                autoPlay: pictures.length > 1,
                onPageChanged: (index, carouselPageChangedReason) {
                  currentIndex.value = index;
                },
                height: picturesHeight,
                viewportFraction: 0.88,
                enableInfiniteScroll: pictures.length > 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
