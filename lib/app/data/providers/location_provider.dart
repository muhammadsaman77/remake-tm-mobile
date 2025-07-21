import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/env/global_var.dart';

class LocationProvider extends GetConnect{
  Future fetchJenisLokasi() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");


      if (token != null) {
        final response = await get('$urlApi/api/vital-locations/types',
            headers: {'Authorization': "Bearer $token","Accept":"application/json"});
        var data = response.body;

        print("data fetchJenisLokasi : $data");

        if (data["success"] != null) {
          if (data["success"]) {
            return data;
          } else {
            errorMessage(
                "Gagal mengambil list jenis lokasi", "${data["message"]}");
            return null;
          }
        } else {
          showLoading();
          // var responseLogout = logout();
          // if (responseLogout != null) {
          //   GetStorage().remove("token");
          //   Get.off(() => LoginView());
          //   onLoadingDismiss();
          //   errorMessage("Token expired", "${data["message"]}");
          // } else {
          //   onLoadingDismiss();
          //   errorMessage("Token expired", "${data["message"]}");
          // }
          return null;
        }
      } else {
        errorMessage("Gagal mengambil list jenis lokasi", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil list jenis lokasi", "$e");
      return null;
    }
  }

  Future fetchDataListLokasi(int idJenis) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");

      String url = '$urlApi/api/vital-locations/?jenis_id=$idJenis';

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data fetchDataListLokasi : $data");

        if (data["success"] != null) {
          if (data["success"]) {
            return data;
          } else {
            errorMessage(
                "Gagal mengambil data list lokasi", "${data["message"]}");
            return null;
          }
        } else {
          // showLoading();
          // var responseLogout = logout();
          // if (responseLogout != null) {
          //   GetStorage().remove("token");
          //   Get.off(() => LoginView());
          //   onLoadingDismiss();
          //   errorMessage("Token expired", "${data["message"]}");
          // } else {
          //   onLoadingDismiss();
          //   errorMessage("Token expired", "${data["message"]}");
          // }
          return null;
        }
      } else {
        errorMessage("Gagal mengambil data list lokasi", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data list lokasi", "$e");
      return null;
    }
  }
}