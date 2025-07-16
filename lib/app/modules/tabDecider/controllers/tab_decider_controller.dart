import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/modules/videoCall/views/video_call_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:talabang_mandau/app/modules/absensi/views/absensi_view.dart';
import 'package:talabang_mandau/app/modules/home/views/home_view.dart';
import 'package:talabang_mandau/app/modules/profile/views/profile_view.dart';

class TabDeciderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement TabDeciderController

  late TabController tabController;

  RxInt selectedIndex = 0.obs;
  List<Widget> pages = [
    HomeView(),
    AbsensiView(),
    // Emergency tab is handled separately
    Container(),
    ProfileView(),
  ];

  void changeTab(int index) {
    if (index == 2) {
      // Emergency tab logic
      _makeEmergencyCall();
    } else {
      selectedIndex.value = index;
    }
  }

  Future<void> _makeEmergencyCall() async {
    final permissionStatus = await Permission.phone.request();
    if (permissionStatus.isGranted) {
      final Uri phoneUri = Uri(scheme: 'tel', path: '110');
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        Get.snackbar('Error', 'Could not make the call',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Permission Denied', 'Phone call permission is required',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onInit() {
    // Initialize TabController
    tabController = TabController(length: pages.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose TabController when the controller is closed
    tabController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
