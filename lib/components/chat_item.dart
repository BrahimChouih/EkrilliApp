import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        title: Text(offer.house?.title ?? ''),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
            offer.house?.pictures.first.picture ?? '',
          ),
        ),
        trailing: StarsWidget(
          stars: offer.house?.stars ?? 0,
          numReviews: offer.house?.numReviews ?? 1,
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
            Text(offer.house?.owner?.username ?? ''),
          ],
        ),
      ),
    );
  }
}
