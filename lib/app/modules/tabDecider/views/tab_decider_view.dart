import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import '../controllers/tab_decider_controller.dart';

class TabDeciderView extends GetView<TabDeciderController> {
  TabDeciderView({super.key});
  @override
  final TabDeciderController tabDeciderController = Get.put(TabDeciderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() =>
      tabDeciderController.pages[tabDeciderController.selectedIndex.value]),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
            () => BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 'Home', 0),
                _buildNavItem(Icons.task, 'Absensi', 1),

                _buildNavItem(Icons.person, 'Profile', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => tabDeciderController.changeTab(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: tabDeciderController.selectedIndex.value == index
                ? primaryColor
                : const Color(0xFFB8B8B8),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: tabDeciderController.selectedIndex.value == index
                  ? primaryColor
                  : const Color(0xFFB8B8B8),
            ),
          ),
        ],
      ),
    );
  }
}
