import 'package:ekrilli_app/screens/create_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../models/offer.dart';
import '../utils/constants.dart';

class OfferItem extends StatelessWidget {
  OfferItem({Key? key, required this.offer}) : super(key: key);
  Offer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: (offer.status == statusPublished
                    ? Colors.yellow
                    : offer.status == statusWaittingForAccepte
                        ? Colors.red
                        : offer.status == statusRented
                            ? Colors.amber
                            : primaryColor)
                .withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: -3,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Dismissible(
        key: ObjectKey(
          offer,
        ),
        background: backgroundSwipping(Alignment.centerLeft),
        secondaryBackground: backgroundSwipping(Alignment.centerRight),
        direction: offer.status == statusPublished ||
                offer.status == statusWaittingForAccepte
            ? DismissDirection.horizontal
            : DismissDirection.none,
        confirmDismiss: (dismissDirection) async {
          print('edit');

          Get.to(
            () => CreateOfferScreen(
              house: offer.house,
              offer: offer,
              isUpdate: true,
            ),
            transition: Transition.rightToLeft,
          );

          return false;
        },
        child: ListTile(
          title: Text(
            offer.status ?? '',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer.pricePerDay.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                'DA/Day',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Text(offer.user?.username ?? ''),
        ),
      ),
    );
  }

  Widget backgroundSwipping(AlignmentGeometry alignment) => Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: borderRadius,
        ),
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Icon(
          FontAwesomeIcons.penToSquare,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      );
}

class OfferItemLoader extends StatelessWidget {
  const OfferItemLoader({
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
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
          child: const ListTile(
            title: Text(''),
            subtitle: Text(''),
          ),
        ),
        items: 10,
        period: const Duration(seconds: 2),
        highlightColor: primaryColor.withOpacity(0.6),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
