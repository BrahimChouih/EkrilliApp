import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class RatingItem extends StatelessWidget {
  const RatingItem({Key? key, required this.rating}) : super(key: key);
  final Rating rating;
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
      ),
      child: ListTile(
        title: Text(rating.offer?.user?.username ?? ''),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: rating.offer?.user?.picture != null
              ? NetworkImage(
                  rating.offer?.user?.picture ?? '',
                )
              : null,
          child: rating.offer?.user?.picture == null
              ? SvgPicture.asset(
                  'assets/vectors/person.svg',
                )
              : null,
        ),
        trailing: StarsWidget(
          stars: rating.stars ?? 0,
          type: StarsWidgetType.digital,
          calculate: false,
        ),
        subtitle: Text(
          rating.comment ?? '',
        ),
      ),
    );
  }
}
