import 'package:ekrilli_app/components/custom_app_bar.dart';
import 'package:ekrilli_app/components/message_field.dart';
import 'package:ekrilli_app/components/message_widget.dart';
import 'package:ekrilli_app/components/offer_action.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/controllers/pagination_controller.dart';
import 'package:ekrilli_app/models/offer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChattingScreen extends StatefulWidget {
  ChattingScreen({Key? key, required this.offer}) : super(key: key);
  final Offer offer;

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  MessagesController messagesController = Get.find<MessagesController>();
  AuthController authController = Get.find<AuthController>();
  Parameters? parameters;
  @override
  void initState() {
    parameters = Parameters(
      offerId: widget.offer.id,
      userId: authController.currentUser!.id!,
    );
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await messagesController.refreshData(parameters: parameters);
    });
    super.initState();
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
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : messagesController.isEmpty
                              ? Container()
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
                  OfferAction(),
                ],
              ),
            ),
            MessageField(offer: widget.offer),
          ],
        ),
      ),
    );
  }
}
