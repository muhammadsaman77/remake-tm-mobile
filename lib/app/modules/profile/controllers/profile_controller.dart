import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/data/dataUser.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  GetStorage box = GetStorage();

  UserData? dataProfile;

  @override
  void onInit() {
    super.onInit();
    getDataProfile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDataProfile() {
    try {
      final stored = box.read("userData");
      if (stored != null) {
        final parsed = stored is String ? jsonDecode(stored) : stored;
        dataProfile = UserData.fromJson(parsed);
        update();
      }
    } catch (e, stack) {
      print("❌ Error parsing userData: $e");
      print(stack);
    }
  }

}
