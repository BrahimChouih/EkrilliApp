import 'package:ekrilli_app/components/stars_widget.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/controllers/messages_controller.dart';
import 'package:ekrilli_app/models/chat_item_model.dart';
import 'package:ekrilli_app/screens/chatting_screen.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class ChatItem extends StatelessWidget {
  ChatItem({Key? key, required this.chatItemModel}) : super(key: key);
  final ChatItemModel chatItemModel;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // print("authController.currentUser!.id != chatItemModel.offer.house.owner!.id");
    // print(authController.currentUser!.id != chatItemModel.offer.house.owner!.id);
    // print("authController.currentUser!.id");
    // print(authController.currentUser!.id);
    // print("chatItemModel.offer.house.owner!.id");
    // print(chatItemModel.offer.house.owner!.id);
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
        // border: Border.all(
        //   color: primaryColor.withOpacity(0.4),
        // ),
      ),
      child: ListTile(
        title: Text(chatItemModel.offer!.house.title ?? ''),
        onTap: () => Get.to(
          () => ChattingScreen(chatItemModel: chatItemModel),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: chatItemModel.offer!.house.pictures.isNotEmpty
              ? NetworkImage(
                  chatItemModel.offer!.house.pictures.first.picture,
                )
              : null,
          child: chatItemModel.offer!.house.pictures.isEmpty
              ? SvgPicture.asset('assets/vectors/house.svg')
              : null,
        ),
        trailing: StarsWidget(
          stars: chatItemModel.offer!.house.stars ?? 0,
          numReviews: chatItemModel.offer!.house.numReviews ?? 1,
          type: StarsWidgetType.digital,
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: deepPrimaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: FaIcon(
                FontAwesomeIcons.userLarge,
                color: authController.currentUser!.id !=
                        chatItemModel.offer!.house.owner!.id
                    ? primaryColor.withOpacity(0.5)
                    : Colors.red.withOpacity(0.5),
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              (Get.find<MessagesController>().isMin(chatItemModel.offer!)
                      ? chatItemModel.user!.username ?? ''
                      : chatItemModel.offer!.house.owner!.username ?? '')
                  .capitalize!,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatLoader extends StatelessWidget {
  const ChatLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SkeletonLoader(
        baseColor: deepPrimaryColor.withOpacity(0.1),
        builder: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.35,
                          height: 10,
                          color: Colors.white,
                        ),
                        Container(
                          width: Get.width * 0.1,
                          height: 10,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: Get.width * 0.25,
                      height: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        items: 7,
        period: const Duration(seconds: 2),
        highlightColor: primaryColor.withOpacity(0.6),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
