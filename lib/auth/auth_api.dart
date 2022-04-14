import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ekrilli_app/controllers/auth_controller.dart';
import 'package:ekrilli_app/models/user.dart';
import 'package:get/get.dart' as getX;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import '../api/api.dart';

class AuthAPI {
  SharedPreferences? sharedPreferences;
  String? apiToken;
  User? currentUser;

  get isLogin => apiToken != null;

  Future<void> signIn({required String email, required String password}) async {
    String apiUrl = '$api/auth/login/';

    Response response = await dio.post(
      apiUrl,
      data: {
        'email': email,
        'password': password,
      },
    );
    apiToken = response.data['token'];
    await setTokenInSP();
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String userType,
  }) async {
    String apiUrl = '$api/auth/register/';

    Response response = await dio.post(
      apiUrl,
      data: {
        'email': email,
        'username': username,
        'password': password,
        'user_type': userType.toUpperCase(),
      },
    );
    apiToken = response.data['token'];
    await setTokenInSP();
  }

  Future<void> signOut() async {
    await sharedPreferences?.clear();
    // if (currentUser != null)
    // FirebaseMessagingHelper.instance.unsubscribeFromTopic(
    //     'userId' + currentUser.id.toString());
    apiToken = null;
    currentUser = null;
  }

  Future<void> getTokenFromSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    apiToken = sharedPreferences?.getString('apiToken');
    if (isLogin) {
      await refreshUserInfo();
    }
  }

  Future<void> setTokenInSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.setString('apiToken', apiToken!);
    await refreshUserInfo();
  }

  Future<User> getUserInfo({int id = 0}) async {
    String apiUrl = '$api/auth/userinfo/$id/';

    options = Options(headers: {
      'Authorization': 'token ${apiToken}',
    });

    Response response = await dio.get(apiUrl, options: options).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw Exception('Check your internet connection !!');
      },
    );
    return User.fromJson(response.data);
  }

  Future<User> updateUserInfo(User user) async {
    String apiUrl = '$api/auth/userinfo/${currentUser?.id}/';

    Map<String, dynamic> userData = user.toJson();
    if (userData['picture'] != null) {
      userData['picture'] = await MultipartFile.fromFile(
        (userData['picture'] as File).path,
        filename: basename((userData['picture'] as File).path),
      );
    }

    FormData formdata = FormData.fromMap(userData);
    Response response;
    response = await dio
        .post(
      apiUrl,
      data: formdata,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
    await refreshUserInfo();
    return User.fromJson(response.data);
  }

  Future<void> refreshUserInfo() async {
    currentUser = await getUserInfo();
  }
}
