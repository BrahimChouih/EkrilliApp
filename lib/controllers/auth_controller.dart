import 'package:ekrilli_app/auth/auth_api.dart';
import 'package:ekrilli_app/helpers/notification_helper.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with AuthAPI {
  Future<void> initData() async {
    await getTokenFromSP();
    if (isLogin) await refreshUserInfo();
  }

  @override
  Future<void> refreshUserInfo() async {
    await super.refreshUserInfo();
    NotificationHelper.subscribeToTopic('userEkrili${currentUser!.id!}');
    NotificationHelper.init();
    update();
  }

  @override
  Future<void> signOut() {
    NotificationHelper.unsubscribeToTopic('userEkrili${currentUser!.id!}');
    Get.delete();
    return super.signOut();
  }
}
