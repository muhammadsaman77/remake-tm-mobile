import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/emergency_controller.dart';

class EmergencyView extends GetView<EmergencyController> {
  const EmergencyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: CText(
          "Emergency",
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        actions: [
          SizedBox(
            height: 48,
            child: Image.asset(
              "assets/icon/logo_telabang_icon.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'EmergencyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
