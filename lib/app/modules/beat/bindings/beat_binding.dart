import 'package:get/get.dart';

import '../controllers/beat_controller.dart';

class BeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeatController>(
      () => BeatController(),
    );
  }
}
