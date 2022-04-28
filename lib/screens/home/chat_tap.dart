import 'package:ekrilli_app/components/chat_item.dart';
import 'package:ekrilli_app/components/empty_screen.dart';
import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../models/offer.dart';

class ChatTap extends StatelessWidget {
  ChatTap({Key? key}) : super(key: key);
  ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Chat'),
            chatController.isEmpty
                ? const EmptyScreen(
                    title: 'No Messages yet',
                    icon: FontAwesomeIcons.comments,
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 50,
                      itemBuilder: (_, index) => ChatItem(
                        offer: chatController.offers.first,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
