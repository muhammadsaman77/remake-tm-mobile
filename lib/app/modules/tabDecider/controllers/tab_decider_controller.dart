import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/data/providers/darurat_provider.dart';
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
    AbsensiView(),
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

  // Triple-tap logic
  int _tapCount = 0;
  DateTime? _lastTapTime;

  void onTripleTap() async{
    final now = DateTime.now();
    if (_lastTapTime == null || now.difference(_lastTapTime!) > const Duration(seconds: 1)) {
      // If the first tap or the time difference between taps is too long, reset the counter
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTapTime = now;

    if (_tapCount == 3) {
      // Triple-tap detected, trigger the emergency call
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
     var data =  await DaruratProvider().createDarurat(position.latitude, position.longitude,position.accuracy);
     if (data["success"]){
       Get.snackbar('Emergency was sent', 'Please wait for instruction',
           snackPosition: SnackPosition.BOTTOM);
     }
      // Reset the counter
      _tapCount = 0;
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