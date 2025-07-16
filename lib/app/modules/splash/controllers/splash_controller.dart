import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/modules/home/views/home_view.dart';
import 'package:talabang_mandau/app/modules/login/views/login_view.dart';
import 'package:talabang_mandau/app/modules/tabDecider/views/tab_decider_view.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        var token = GetStorage().read("token");
        print("token:$token");
        if (token == null) {
          Get.off(() => LoginView());
        } else {
          Get.off(() => TabDeciderView());
        }
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
