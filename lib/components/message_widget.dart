import 'dart:convert';
import 'dart:math';

import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer_sended.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../utils/constants.dart';

import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({
    Key? key,
    required this.message,
    this.isMe = true,
  }) : super(key: key);
  final Message message;
  final bool isMe;
  TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    textStyle = TextStyle(
      fontWeight: !isMe ? null : FontWeight.bold,
      color: Colors.black.withOpacity(0.7),
      fontSize: 14,
    );
    return Row(
      mainAxisAlignment:
          !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: !isMe
                ? Colors.grey.withOpacity(0.2)
                : primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(
              message.contentType == messageContentTypeOfferInfo ? 5 : 20,
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.6,
            ),
            child: Column(
              children: [
                message.contentType == messageContentTypeMessage
                    ? messageText()
                    : const SizedBox(),
                message.contentType == messageContentTypeImage
                    ? messageImage()
                    : const SizedBox(),
                message.contentType == messageContentTypeOfferInfo
                    ? messageOffer()
                    // ? messageText()
                    : const SizedBox(),
                message.contentType == messageContentTypeAction
                    ? messageAction()
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget messageText() => Text(
        (message.message ?? ''),
        style: textStyle,
      );

  Widget messageImage() => Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            child: const CircularProgressIndicator(),
          ),
          Image.network(message.image!),
        ],
      );
  Widget messageOffer() {
    final data = json.decode(message.message!);

    OfferSended offerSended = OfferSended.fromJson(data);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          !isMe ? "He sent you an offer:" : "You sent him an offer:",
          style: textStyle,
        ),
        Text(
          "Start date: " +
              DateFormat(dateTimeFormat).format(offerSended.startDate!),
          style: textStyle,
        ),
        Text(
          "End date: " +
              DateFormat(dateTimeFormat).format(offerSended.endDate!),
          style: textStyle,
        ),
      ],
    );
  }

  Widget messageAction() => Text("Action");
}

class MessageLoader extends StatelessWidget {
  const MessageLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SkeletonLoader(
        baseColor: deepPrimaryColor.withOpacity(0.1),
        builder: Builder(builder: (context) {
          MainAxisAlignment mainAxisAlignment = Random().nextBool()
              ? MainAxisAlignment.start
              : MainAxisAlignment.end;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: <Widget>[
                Container(
                  width: Get.width * 0.3,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }),
        items: 30,
        period: const Duration(seconds: 2),
        highlightColor: primaryColor.withOpacity(0.6),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
