import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ekrilli_app/models/message.dart';
import 'package:ekrilli_app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

  return Future<void>.value();
}

class NotificationHelper {
  static Function()? onMessage;
  static int currentOfferId = 0;
  static bool hasListener = false;
  static void init() {
    requestPermission();
    loadFCM();
    listenFCM();
  }

  static void subscribeToTopic(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static void unsubscribeToTopic(String topic) {
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  static void listenFCM() async {
    if (!hasListener) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        Map<String, dynamic> data = jsonDecode(message.data['messageData']);
        Message messageModel = Message.fromJson(data);
        try {
          if (onMessage != null) await onMessage!();
        } catch (e) {
          print(e);
        }
        if (notification != null && currentOfferId != messageModel.offer!.id) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: messageModel.id!,
              channelKey: 'chat_channel',
              groupKey: 'chat_groupe_channel',
              title: message.notification!.title!.toUpperCase(),
              body: messageModel.contentType == messageContentTypeMessage ||
                      messageModel.contentType == messageContentTypeAction
                  ? messageModel.message
                  : messageModel.contentType,
            ),
          );
        }
      });
      hasListener = true;
    }
  }

  static void loadFCM() async {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/notification_icon',
      [
        NotificationChannel(
          channelGroupKey: 'chat_channel_group',
          channelKey: 'chat_channel',
          channelName: 'Message',
          channelDescription: 'Notification channel for chat',
          defaultColor: primaryColor,
          ledColor: Colors.white,
          enableVibration: true,
          playSound: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupkey: 'chat_groupe_channel',
          channelGroupName: 'Messages',
        ),
      ],

      debug: true,
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}




  // void sendPushMessage() async {
  //   try {
  //     await Dio().post(
  //       'https://fcm.googleapis.com/fcm/send',
  //       options: Options(
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //           'Authorization':
  //               'key=AAAA4lm4s_w:APA91bGRuvN6Ffk6aJ-2RzG9IUjv1u4oqY6GXCA7N42bJhf6ksN7Po5Wmt1idPYrYoRFaHUC2LWr3Te70bS1YByvRgNoDos-8gU2nWSerAz0zrvrDq93xMBy6Yk69gnRfPQjvP_HKWNT',
  //         },
  //       ),
  //       data: jsonEncode(
  //         <String, dynamic>{
  //           'notification': <String, dynamic>{
  //             'body': 'Test Body',
  //             'title': 'Test Title 2'
  //           },
  //           'priority': 'high',
  //           'data': <String, dynamic>{
  //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //             'id': '1',
  //             'status': 'done'
  //           },
  //           // "to": "/topics/Animal",
  //           "to": "$token",
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     print("error push notification");
  //   }
  // }