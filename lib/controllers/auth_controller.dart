import 'package:ekrilli_app/auth/auth_api.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class AuthController extends GetxController with AuthAPI {
  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    await getTokenFromSP();
    if (isLogin) refreshUserInfo();
  }

  @override
  Future<void> refreshUserInfo() async {
    await super.refreshUserInfo();
    update();
  }
}
