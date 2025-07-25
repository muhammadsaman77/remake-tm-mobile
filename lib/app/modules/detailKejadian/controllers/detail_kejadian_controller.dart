import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/data/kejadianDetail.dart';
import 'package:talabang_mandau/app/data/kejadianItem.dart';
import 'package:talabang_mandau/app/data/providers/incident_provider.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';

class DetailKejadianController extends GetxController {
  //TODO: Implement DetailKejadianController
  final incidentProvider = IncidentProvider();
  GetStorage box = GetStorage();
  var dataArguments = Get.arguments;
  Kejadian? dataKejadian;

  RxBool isDetailKejadianExist = false.obs;
  KejadianDetail? dataDetailKejadian;

  RxList<Map<String, dynamic>> dataLog = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    dataKejadian = dataArguments["dataKejadian"];
    print("dataArguments:${dataKejadian!.id}");
    fetchDataDetailKejadian();
  }

  fetchDataDetailKejadian() async {
    isDetailKejadianExist.value = false;

    var response =
        await incidentProvider.fetchDataDetailKejadian(dataKejadian!.id);
    print("response: $response");

    if (response["payload"] != null) {
      dataDetailKejadian =
          KejadianDetail.fromJson(response["payload"]["incident"]);

      // Ambil data log
      if (response["payload"]["log"] != null) {
        print(response);
        dataLog.value =
            List<Map<String, dynamic>>.from(response["payload"]["log"]);
        print(dataLog.value);
        updateDataWithLatestLog();
      }

      isDetailKejadianExist.value = true;
      update();
    } else {
      errorMessage(
        "Terjadi kesalahan",
        "Gagal mengambil data detail kejadian",
      );
      isDetailKejadianExist.value = false;
    }
  }

  // Perbarui data utama menggunakan log terbaru
  void updateDataWithLatestLog() {
    if (dataLog.isNotEmpty) {
      final latestLog = dataLog.last;
      dataDetailKejadian!.keterangan = latestLog["detail"];
      if (latestLog["dokumentasi"] != null) {
        dataDetailKejadian!.dokumentasi = latestLog["dokumentasi"];
      }
      update();
    }
  }
}
