import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fcmToken;
  @override
  void onInit() {
    super.onInit();

    requestPermission();
    getToken();
  }

  void requestPermission() async {

    NotificationSettings? settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User denied access');
      }
    }
  }

  void getToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print("My FCM token is $fcmToken");
    }
  }
}