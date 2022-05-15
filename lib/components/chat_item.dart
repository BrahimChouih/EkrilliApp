import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/screens/chatting_screen.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.offer}) : super(key: key);
  final Offer offer;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: -3,
            offset: const Offset(2, 2),
          ),
        ],
        // border: Border.all(
        //   color: primaryColor.withOpacity(0.4),
        // ),
      ),
      child: ListTile(
        title: Text(offer.house.title ?? ''),
        onTap: () => Get.to(
          () => ChattingScreen(offer: offer),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: offer.house.pictures.isNotEmpty
              ? NetworkImage(
                  offer.house.pictures.first.picture,
                )
              : null,
          child: offer.house.pictures.isEmpty
              ? SvgPicture.asset('assets/vectors/house.svg')
              : null,
        ),
        trailing: StarsWidget(
          stars: offer.house.stars ?? 0,
          numReviews: offer.house.numReviews ?? 1,
          type: StarsWidgetType.digital,
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: deepPrimaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: FaIcon(
                FontAwesomeIcons.userLarge,
                color: primaryColor.withOpacity(0.5),
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(offer.house.owner?.username ?? ''),
          ],
        ),
      ),
    );
  }
}

class ChatLoader extends StatelessWidget {
  const ChatLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SkeletonLoader(
        baseColor: deepPrimaryColor.withOpacity(0.1),
        builder: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.35,
                          height: 10,
                          color: Colors.white,
                        ),
                        Container(
                          width: Get.width * 0.1,
                          height: 10,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: Get.width * 0.25,
                      height: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        items: 7,
        period: const Duration(seconds: 2),
        highlightColor: primaryColor.withOpacity(0.6),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
