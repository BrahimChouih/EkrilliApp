import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RoomsNumberWidget extends StatelessWidget {
  const RoomsNumberWidget({
    Key? key,
    this.kitchens = 1,
    this.bathrooms = 1,
    this.bedrooms = 1,
    this.color,
    this.size,
    this.textStyle,
  }) : super(key: key);
  final int kitchens;
  final int bathrooms;
  final int bedrooms;
  final Color? color;
  final double? size;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rooms(
          rooms: kitchens,
          icon: FontAwesomeIcons.kitchenSet,
        ),
        rooms(
          rooms: bathrooms,
          icon: FontAwesomeIcons.toilet,
        ),
        rooms(
          rooms: bedrooms,
          icon: FontAwesomeIcons.bed,
        ),
      ],
    );
  }

  Row rooms({required int rooms, required IconData icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(
          icon,
          color: color ?? Colors.white,
          size: size ?? 20,
        ),
        const SizedBox(width: 15),
        Text(
          rooms.toString(),
          style: (textStyle ?? Get.theme.textTheme.headline6)?.copyWith(
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
