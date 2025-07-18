import 'dart:developer' as developer;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/data/kegiatanDetail.dart';
import 'package:talabang_mandau/app/data/kegiatanItem.dart';
import 'package:talabang_mandau/app/data/providers/activity_provider.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';

class DetailKegiatanController extends GetxController {
  final activityProvider = ActivityProvider();
  GetStorage box = GetStorage();
  var dataArguments = Get.arguments;
  Kegiatan? dataKegiatan;

  RxBool isDetailKegiatanExist = false.obs;
  KegiatanDetail? dataDetailKegiatan;

  RxList<Map<String, dynamic>> dataLog = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    dataKegiatan = dataArguments["dataKegiatan"];
    print("dataArguments:${dataKegiatan!.id}");
    fetchDataDetailKegiatan();

    developer.log(box.read("token"));
  }

  fetchDataDetailKegiatan() async {
    isDetailKegiatanExist.value = false;

    var response =
        await activityProvider.fetchDataDetailKegiatan(dataKegiatan!.id);
    print("response: $response");

    if (response["payload"] != null) {
      dataDetailKegiatan =
          KegiatanDetail.fromJson(response["payload"]);

      // Ambil data log
      // if (response["data"]["kegiatan_log"] != null) {
      //   dataLog.value =
      //       List<Map<String, dynamic>>.from(response["data"]["kegiatan_log"]);
      // }

      isDetailKegiatanExist.value = true;
      update();
    } else {
      errorMessage(
        "Terjadi kesalahan",
        "Gagal mengambil data detail kegiatan",
      );
      isDetailKegiatanExist.value = false;
    }
  }

  // Perbarui data utama menggunakan log terbaru
  void updateDataWithLatestLog() {
    if (dataLog.isNotEmpty) {
      final latestLog = dataLog.last;
      dataDetailKegiatan!.detail = latestLog["detail"];
      if (latestLog["dokumentasi"] != null) {
        dataDetailKegiatan!.dokumentasi = latestLog["dokumentasi"];
      }
      update();
    }
  }
}
