import 'package:ekrilli_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.message,
    this.isMe = true,
  }) : super(key: key);
  final Message message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe
                ? primaryColor.withOpacity(0.5)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ((message.message ?? '') + ' '),
                  style: TextStyle(
                    fontWeight: isMe ? FontWeight.bold : null,
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),

                //  Stack(
                //           children: [
                //             Container(
                //               alignment: Alignment.center,
                //               height: 100,
                //               child: CircularProgressIndicator(),
                //             ),
                //             Image.network(widget.message.image),
                //           ],
                //         ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
