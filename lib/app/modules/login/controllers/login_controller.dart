import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/providers/auth_providers.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/app/modules/tabDecider/views/tab_decider_view.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPassword = true.obs;
  GetStorage box = GetStorage();

  String? fcmToken;

  @override
  void onInit() {
    super.onInit();
    _getFCMToken();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _getFCMToken() async {
    try {
      final FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Dapatkan token FCM
      String? token = await messaging.getToken();
      print('FCM Token: $token');

      fcmToken = token;

      // Simpan token ke server Anda jika diperlukan
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }

  void login() async {
    showLoading();
    print("token");
    print(fcmToken!);
    print("token");
    var loginResponse = await AuthProvider()
        .login(usernameController.text, passwordController.text, fcmToken!);

    if (loginResponse != null) {
      String token = loginResponse["payload"]["access_token"];
      box.write('token', token);
      box.write('username', usernameController.text);
      Get.off(() => TabDeciderView());
      onLoadingDismiss();
    } else {
      onLoadingDismiss();
    }
    print("loginResponse: $loginResponse");
  }
}
