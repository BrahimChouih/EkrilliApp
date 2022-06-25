import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/components/text_field_with_title.dart';
import 'package:ekrilli_app/data/api/api.dart';
import 'package:ekrilli_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IpScreen extends StatelessWidget {
  IpScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController(text: api);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFielWithTitle(
              controller: controller,
              title: 'Ip',
            ),
            SubmitButton(
              text: 'OK',
              onTap: () {
                api = controller.text;
                Get.offAll(SplashScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
