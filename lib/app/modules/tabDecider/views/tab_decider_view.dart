import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/env/colors.dart';

import '../controllers/tab_decider_controller.dart';

class TabDeciderView extends GetView<TabDeciderController> {
  TabDeciderView({super.key});
  @override
  TabDeciderController tabDeciderController = Get.put(TabDeciderController());
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() =>
          tabDeciderController.pages[tabDeciderController.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Color(0xFFB8B8B8),
          unselectedLabelStyle: TextStyle(color: Color(0xFFB8B8B8)),
          currentIndex: tabDeciderController.selectedIndex.value,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          onTap: tabDeciderController.changeTab,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.task),
              label: 'Absensi',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.emergency),
              label: 'Emergency',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
