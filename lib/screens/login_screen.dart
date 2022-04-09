import 'package:dio/dio.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  AuthController authController = Get.find<AuthController>();

  TextEditingController emailController =
      TextEditingController(text: 'test1@gmail.com');

  TextEditingController usernameController =
      TextEditingController(text: 'test1');

  TextEditingController passwordController =
      TextEditingController(text: '123123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              textField('email', emailController),
              textField('username', usernameController),
              textField('password', passwordController),
              TextButton(
                onPressed: () async {
                  try {
                    // await authController.signOut();
                    // await authController.signIn(
                    //   email: emailController.text,
                    //   password: passwordController.text,
                    // );
                    // await authController.signUp(
                    //   email: emailController.text,
                    //   password: passwordController.text,
                    //   username: usernameController.text,
                    // );
                    await authController.updateUserInfo(
                      User(location: 'Oran'),
                    );
                  } on DioError catch (e) {
                    print('===========');
                    print(e.response);
                    print('===========');
                  }

                  print(authController.currentUser?.toJson());

                  authController.update();
                },
                child: const Text('submit'),
              ),
              GetBuilder<AuthController>(
                builder: (_) => Text(
                  authController.currentUser?.toJson().toString() ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(
    String hint,
    TextEditingController controller,
  ) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
        ),
      );
}
