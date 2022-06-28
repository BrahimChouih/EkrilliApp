import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/models/chat_item_model.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class MessageField extends StatelessWidget {
  MessageField({Key? key, required this.chatItemModel}) : super(key: key);

  final ChatItemModel chatItemModel;
  final MessagesController messagesController = Get.find<MessagesController>();

  TextEditingController textFieldController = TextEditingController();

  FocusNode focusNode = FocusNode();

  void sendMessage() async {
    if (textFieldController.text.isNotEmpty) {
      messagesController.sendMessage(
        offerId: chatItemModel.offer!.id!,
        userId: chatItemModel.user!.id!,
        message: Message(
          message: textFieldController.text,
          messageType: messagesController.messageType(chatItemModel),
        ),
      );
      textFieldController.clear();
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.photo_library_rounded,
              color: deepPrimaryColor,
            ),
          ),
          Expanded(
            child: TextField(
              controller: textFieldController,
              onSubmitted: (value) {
                sendMessage();
              },
              focusNode: focusNode,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
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
