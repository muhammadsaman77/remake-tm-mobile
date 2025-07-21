import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/env/global_var.dart';

class IncidentProvider extends GetConnect{
  Future createIncident(String date, double lat, double lng, String lokasi,
      String keterangan, int idJenisKejadian, File imageFile) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");


      final formData = FormData({
        'waktu_kejadian': date,
        'lat': lat,
        'lng': lng,
        'lokasi': lokasi,
        'keterangan': keterangan,
        'id_jenis_kejadian': idJenisKejadian,
        'dokumentasi':
        MultipartFile(imageFile, filename: imageFile.path.split('/').last),
      });
      if (token != null) {
        final response = await post('$urlApi/api/incidents/', formData,
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data createIncident : $data");

        if (response.isOk) {
          return data;
        } else {
          errorMessage("Gagal Membuat Kejadian", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal Membuat Kejadian", "Token kosong");

        return null;
      }
    } catch (e) {
      errorMessage("Gagal Membuat Kejadian", "$e");
      return null;
    }
  }
  Future fetchDataListKejadian(String status, int durasi) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = "$urlApi/api/incidents";

      // if (status == "SELESAI") {
      //   url =
      //       '$urlApi/kejadian/list?nrp=$username&status=$status&durasi=$durasi';
      // } else {
      //   url = '$urlApi/kejadian/list?nrp=$username&status=$status';
      // }

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data fetchDataListKejadian : $data");

        if (response.isOk) {
          return data;
          // if (data["ok"]) {
          //   return data;
          // } else {
          //   errorMessage(
          //       "Gagal mengambil data list kejadian", "${data["message"]}");
          //   return null;
          // }
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
          // return null;
        }
      } else {
        errorMessage("Gagal mengambil data list kejadian", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data list kejadian", "$e");
      return null;
    }
  }

  Future fetchDataDetailKejadian(int id) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = '$urlApi/api/incidents/$id';

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data detail kejadian : $data");

        if (response.isOk) {
          return data;
        } else {
          // showLoading();
          // var responseLogout = await logout();
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
        errorMessage("Gagal mengambil data kejadian", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data kejadian", "$e");
      return null;
    }
  }
  Future updateKejadian(int idKejadian, String detail, File? dokumentasi,
      String status, double lat, double lng) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      final formData = FormData({
        "nrp": username,
        "id_kejadian": idKejadian,
        "detail": detail,
        "status": status,
        "lat": lat,
        "lng": lng,
        'dokumentasi': MultipartFile(dokumentasi,
            filename: dokumentasi!.path.split('/').last),
      });

      if (token != null) {
        final response = await post('$urlApi/kejadian/update', formData,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data update kejadian : $data");

        if (data["ok"]) {
          return data;
        } else {
          errorMessage("Gagal update kejadian", "${data["message"]}");
          print("update kegiatan: ${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal update kejadian", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Terjadi kesalahan", "Gagal update kejadian");

      return null;
    }
  }
  Future fetchJenisKejadian() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      if (token != null) {
        final response = await get('$urlApi/api/incidents/types',
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data fetchJenisKejadian : $data");

        if (response.isOk) {
  return data;
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
        errorMessage("Gagal mengambil list jenis kejadian", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil list jenis kejadian", "$e");
      return null;
    }
  }

}