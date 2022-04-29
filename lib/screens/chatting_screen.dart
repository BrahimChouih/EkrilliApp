import 'dart:ui';

import 'package:ekrilli_app/components/custom_app_bar.dart';
import 'package:ekrilli_app/components/custom_text_field.dart';
import 'package:ekrilli_app/components/message_field.dart';
import 'package:ekrilli_app/components/message_widget.dart';
import 'package:ekrilli_app/components/offer_action.dart';
import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChattingScreen extends StatelessWidget {
  ChattingScreen({Key? key, required this.offer}) : super(key: key);
  final Offer offer;
  MessagesController messagesController = Get.put(MessagesController());
  bool isMe = false;
  // bool isMe = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Chatting',
              backButton: true,
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: 200,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) =>
                        MessageWidget(
                      message: messagesController.messages.first,
                      isMe: index % 3 != 0,
                    ),
                  ),
                  const OfferAction(),
                ],
              ),
            ),
            const MessageField(),
          ],
        ),
      ),
    );
  }
}
