import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/dataUser.dart';
import 'package:talabang_mandau/app/data/providers/call_providers.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/app/modules/videoCall/screens/videocall.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  UserData? dataProfile;
  GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    fetchDataProfile();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  firebaseInit() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission for iOS
    messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM Token
    messaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received in foreground: ${message.notification?.title}');
      if (message.notification != null) {
        print('Notification Body: ${message.notification?.body}');
        // You can use a dialog, snackbar, or custom UI to display the message
        confirmMessage(
            Get.context, "Video Call Masuk", "Join panggilan Video Call?", () {
          if (!isCallOngoing) {
            Get.back();
            fetchDataSessions();
          }
        });

        // showDialog(
        //   context: Get.context!,
        //   builder: (_) => AlertDialog(
        //     title: Text(message.notification!.title ?? 'No Title'),
        //     content: Text(message.notification!.body ?? 'No Body'),
        //   ),
        // );
      }
    });

    // Handle messages tapped by user
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked: ${message.notification?.title}');
    });
  }

  fetchDataProfile() async {
    var responseFetchDataProfile = await ServiceProvider().fetchDataProfile();

    print("responseFetchDataProfile: $responseFetchDataProfile");

    if (responseFetchDataProfile != null) {
      if (responseFetchDataProfile["ok"]) {
        box.write("userData", responseFetchDataProfile["data"]);
        print("userData: ${box.read("userData")}");
        dataProfile = UserData.fromJson(box.read("userData"));
        print("Nama User: ${dataProfile!.absensiWaktuDatang}");
        update();
      }
    }
  }

  bool isCallOngoing = false;

  Future fetchDataSessions() async {
    showLoading();
    var response = await CallProviders().getSessionId();

    print("fetchDataSessions:$response");


      if (response["payload"] != null) {

        startVidcall(response["payload"]["session_name"]);
        onLoadingDismiss();
      } else {
        onLoadingDismiss();
      }

  }

  startVidcall(sessionName) {
      isCallOngoing = true; // Tandai panggilan sedang berlangsung
    Navigator.push(Get.context!, MaterialPageRoute(builder: (context) {
      // _saveSharedPref();
      return VideocallWidget(
        server: 'dsn-appdev.web.id/tm-vcall-server',
        sessionId: sessionName,
        userName: "saman",
        secret: "dsn@ppD3V24",
        iceServer: "stun.l.google.com:19302",
      );
    })).then((_) {
      // Reset status panggilan ketika kembali dari video call
      isCallOngoing = false;
    });
  }

  convertTime(originalDate) {
    // Parse string ke DateTime
    print("originalDate:$originalDate");
    String formattedDate = "";
    if (originalDate != null) {
      DateTime dateTime = originalDate;

      // Format ke 19/12/2024 14:44
      formattedDate = DateFormat("HH:mm").format(dateTime);
    } else {
      formattedDate = "-.-.-";
    }

    return formattedDate; // Output: 19/12/2024 14:44
  }
}
