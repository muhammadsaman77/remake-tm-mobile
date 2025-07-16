import 'package:get/get.dart';

import '../controllers/create_kegiatan_controller.dart';

class CreateKegiatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateKegiatanController>(
      () => CreateKegiatanController(),
    );
  }
}
