import 'package:ekrilli_app/components/chat_item.dart';
import 'package:ekrilli_app/components/empty_screen.dart';
import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../models/offer.dart';

class ChatTap extends StatefulWidget {
  ChatTap({Key? key}) : super(key: key);

  @override
  State<ChatTap> createState() => _ChatTapState();
}

class _ChatTapState extends State<ChatTap> {
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    if (chatController.isEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
        chatController.changeLoadingState(true);
        await Future.delayed(const Duration(milliseconds: 300));
        chatController.getOffersByMessages();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Chat'),
            GetBuilder<ChatController>(
              builder: (context) {
                return chatController.isLoading
                    ? const ChatLoader()
                    : chatController.isEmpty
                        ? const EmptyScreen(
                            title: 'No Messages yet',
                            icon: FontAwesomeIcons.comments,
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await chatController.getOffersByMessages();
                              },
                              child: SizedBox(
                                height: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: chatController.offers.length,
                                  itemBuilder: (_, index) => ChatItem(
                                    offer: chatController.offers[index],
                                  ),
                                ),
                              ),
                            ),
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
