import 'package:ekrilli_app/components/custom_app_bar.dart';
import 'package:ekrilli_app/components/message_field.dart';
import 'package:ekrilli_app/components/message_widget.dart';
import 'package:ekrilli_app/components/offer_action.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/helpers/notification_helper.dart';
import 'package:ekrilli_app/models/chat_item_model.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({Key? key, required this.chatItemModel}) : super(key: key);
  final ChatItemModel chatItemModel;

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  MessagesController messagesController = Get.find<MessagesController>();
  Parameters? parameters;
  ScrollController messagesScrollController = ScrollController();

  @override
  void initState() {
    parameters = Parameters(
      offer: widget.chatItemModel.offer,
      user: widget.chatItemModel.user,
    );

    messagesController.parameters = parameters;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 150));
      await messagesController.refreshData(parameters: parameters);
      await messagesController.chatOfferSended(parameters: parameters!);
    });

    messagesScrollController.addListener(() {
      if ((messagesScrollController.position.maxScrollExtent * 0.9) <
          messagesScrollController.position.pixels) {
        messagesController.getNextPage();
      }
    });
    NotificationHelper.currentOfferId = parameters!.offer!.id!;
    NotificationHelper.onMessage = () async {
      await messagesController.initData(parameters: parameters);
      await messagesController.chatOfferSended(parameters: parameters!);
      messagesController.changeLoadingState(false);
    };
    super.initState();
  }

  @override
  void dispose() {
    NotificationHelper.currentOfferId = 0;
    NotificationHelper.onMessage = () {
      Get.find<ChatController>().getChatItems(withWait: false);
    };
    super.dispose();
  }

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
                  GetBuilder<MessagesController>(
                    builder: (context) {
                      return messagesController.isLoading
                          ? const MessageLoader()
                          : messagesController.isEmpty
                              ? const SizedBox()
                              : ListView.builder(
                                  itemCount: messagesController.messages.length,
                                  reverse: true,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          MessageWidget(
                                    message: messagesController.messages[index],
                                    isMe: messagesController.isMe(
                                      messagesController.messages[index],
                                    ),
                                  ),
                                );
                    },
                  ),
                  GetBuilder<MessagesController>(
                    id: messagesController.offerSendedId,
                    builder: (_) => OfferAction(
                      offerSended: messagesController.offerSended,
                    ),
                  ),
                ],
              ),
            ),
            MessageField(
              chatItemModel: widget.chatItemModel,
            ),
          ],
        ),
      ),
    );
  }
}
