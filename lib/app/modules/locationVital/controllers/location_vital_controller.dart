import 'package:get/get.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';

class LocationVitalController extends GetxController {
  //TODO: Implement LocationVitalController

  List<LokasiVital> listLokasi = [];
  RxBool isListLokasiExist = false.obs;

  RxList listJenisLokasi = [].obs;
  JenisLokasi? jenisLokasi;
  @override
  void onInit() {
    super.onInit();
    fetchJenisLokasi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchJenisLokasi() async {
    var response = await ServiceProvider().fetchJenisLokasi();

    print("response: $response");

    if (response != null) {
      List listData = response["data"];
      for (var i = 0; i < listData.length; i++) {
        listJenisLokasi.add(
            JenisLokasi(id: listData[i]["id"], jenis: listData[i]["jenis"]));
      }

      jenisLokasi = listJenisLokasi[0];
      fetchDataListLokasi();
    }
  }

  fetchDataListLokasi() async {
    isListLokasiExist.value = false;

    var response = await ServiceProvider().fetchDataListLokasi(jenisLokasi!.id);

    print("response:$response");

    if (response != null) {
      if (response["ok"]) {
        listLokasi = (response["data"] as List<dynamic>)
            .map((item) => LokasiVital(
                  namaTempat: item["nama_tempat"],
                  lokasi: item["lokasi"],
                  lat: item["lat"],
                  lng: item["lng"],
                  noTelp: item["no_telp"] ?? null,
                ))
            .toList();

        print("listLokasi:${listLokasi}");
        isListLokasiExist.value = true;
        update();
      } else {
        isListLokasiExist.value = true;
        update();
      }
    }
  }
}

class JenisLokasi {
  final int id;
  final String jenis;

  JenisLokasi({
    required this.id,
    required this.jenis,
  });
}

class LokasiVital {
  final String namaTempat;
  final String lokasi;
  final double lat;
  final double lng;
  final String? noTelp;

  LokasiVital({
    required this.namaTempat,
    required this.lokasi,
    required this.lat,
    required this.lng,
    this.noTelp,
  });
}
