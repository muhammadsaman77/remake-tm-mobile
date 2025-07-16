import 'package:get/get.dart';

import '../controllers/riwayat_patroli_controller.dart';

class RiwayatPatroliBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatPatroliController>(
      () => RiwayatPatroliController(),
    );
  }
}
