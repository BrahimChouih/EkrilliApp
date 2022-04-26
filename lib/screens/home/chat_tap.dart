import 'package:ekrilli_app/components/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';

class ChatTap extends StatelessWidget {
  const ChatTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.02),
            CustomAppBar(title: 'Chat'),
            const Spacer(),
            FaIcon(
              FontAwesomeIcons.comments,
              color: Colors.grey.withOpacity(0.2),
              size: Get.width * 0.4,
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              'No Messages yet',
              style: Get.theme.textTheme.bodyText1?.copyWith(
                fontSize: 21,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
