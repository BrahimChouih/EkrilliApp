import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ekrilli_app/components/custom_drop_dwon.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:ekrilli_app/screens/home_screen.dart';
import 'package:ekrilli_app/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../components/custom_text_field.dart';
import '../components/submit_button.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthController authController = Get.find<AuthController>();

  TextEditingController emailController =
      TextEditingController(text: 'test3@gmail.com');

  TextEditingController usernameController =
      TextEditingController(text: 'test3');

  TextEditingController passwordController =
      TextEditingController(text: '123123');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123123');

  Rx<AuthenticationMode> authenticationMode = AuthenticationMode.signIn.obs;

  String? accountType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.4,
                    child: authenticationMode.value == AuthenticationMode.signIn
                        ? SvgPicture.asset('assets/vectors/sign_in.svg')
                        : SvgPicture.asset('assets/vectors/sign_up.svg'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      authModeButton(AuthenticationMode.signIn),
                      authModeButton(AuthenticationMode.signUp),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.03),
                  CustomTextField(
                    hintText: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  authenticationMode.value == AuthenticationMode.signUp
                      ? CustomTextField(
                          hintText: 'Username',
                          controller: usernameController,
                        )
                      : const SizedBox(),
                  CustomTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  authenticationMode.value == AuthenticationMode.signUp
                      ? CustomTextField(
                          hintText: 'Confirm Password',
                          controller: confirmPasswordController,
                          obscureText: true,
                        )
                      : const SizedBox(),
                  authenticationMode.value == AuthenticationMode.signUp
                      ? CustomDropDown<String>(
                          items: const ['Owner', 'Tanent'],
                          value: accountType,
                          onChange: (val) {
                            accountType = val;
                            authenticationMode.refresh();
                          },
                        )
                      : const SizedBox(),
                  SubmitButton(
                    text: authenticationMode.value == AuthenticationMode.signIn
                        ? 'Sign In'
                        : 'Sign Up',
                    onTap: () async {
                      // print(accountType);
                      try {
                        if (authenticationMode.value ==
                            AuthenticationMode.signIn) {
                          await authController.signIn(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } else {
                          await authController.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            username: usernameController.text,
                            userType: accountType ?? 'Tanent',
                          );
                        }
                        if (authController.isLogin) {
                          Get.offAll(() => HomeScreen());
                        }
                      } on DioError catch (e) {
                        Get.defaultDialog(
                          title: 'Error',
                          content: Text(
                            (e.response ?? 'Check your internet connection')
                                .toString(),
                          ),
                          confirm: TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Ok'),
                          ),
                        );
                        print('===========');
                        print(e.response);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget authModeButton(AuthenticationMode authMode) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          authenticationMode.value = authMode;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Text(
            authMode == AuthenticationMode.signIn ? 'Sign In' : 'Sign Up',
            style: TextStyle(
              color: authenticationMode.value == authMode ? primaryColor : null,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

enum AuthenticationMode {
  signIn,
  signUp,
}
