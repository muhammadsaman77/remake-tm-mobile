import 'package:get/get.dart';

import '../controllers/ht_controller.dart';

class HtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HtController>(
      () => HtController(),
    );
  }
}
