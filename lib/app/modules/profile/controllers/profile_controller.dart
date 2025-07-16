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
  }

  @override
  void onReady() {
    super.onReady();
    getDataProfile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDataProfile() {
    if (box.read("userData") != null) {
      dataProfile = UserData.fromJson(box.read("userData"));
      update();
    }
  }
}
