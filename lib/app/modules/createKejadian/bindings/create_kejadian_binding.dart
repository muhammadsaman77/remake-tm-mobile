import 'package:get/get.dart';

import '../controllers/create_kejadian_controller.dart';

class CreateKejadianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateKejadianController>(
      () => CreateKejadianController(),
    );
  }
}
