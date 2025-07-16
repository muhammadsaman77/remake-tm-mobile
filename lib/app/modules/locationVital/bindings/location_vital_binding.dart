import 'package:get/get.dart';

import '../controllers/location_vital_controller.dart';

class LocationVitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationVitalController>(
      () => LocationVitalController(),
    );
  }
}
