import 'package:ekrilli_app/auth/auth_api.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class AuthController extends GetxController with AuthAPI {
  Future<void> initData() async {
    await getTokenFromSP();
    if (isLogin) await refreshUserInfo();
  }

  @override
  Future<void> refreshUserInfo() async {
    await super.refreshUserInfo();
    update();
  }
}
