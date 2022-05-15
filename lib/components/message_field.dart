import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class MessageField extends StatelessWidget {
  MessageField({Key? key, required this.offer}) : super(key: key);
  final Offer offer;
  final MessagesController messagesController = Get.find<MessagesController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.photo_library_rounded,
              color: deepPrimaryColor,
            ),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              // messagesController.sendMessage(
              //   offerId: offerId,
              //   userId: userId,
              //   message: Message(message: ''),
              // );
            },
            icon: const Icon(
              Icons.send,
              color: deepPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
