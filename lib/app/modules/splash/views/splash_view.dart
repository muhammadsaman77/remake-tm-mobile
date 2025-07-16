import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});
  @override
  SplashController controller = Get.put(SplashController());
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 160,
            child: Image.asset(
              "assets/icon/logo_telabang_icon.png",
              fit: BoxFit.cover,
            ),
          ),
          CText(
            "Telabang Mandau Nusantara",
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 28,
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }
}
