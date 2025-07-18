import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/env/global_var.dart';

class ActivityProvider extends GetConnect{
  Future fetchDataListKegiatan(String status, int durasi) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = "$urlApi/api/activities";

      // if (status == "Semua") {
      //   url =
      //       '$urlApi/kegiatan/list?nrp=$username&status=$status&durasi=$durasi';
      // } else {
      //   url = '$urlApi/kegiatan/list?nrp=$username&status=$status';
      // }

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data fetchDataProfile : $data");
        if (response.isOk){
          return data;
        }else{
          return null;
        }
        // if (response.isOk) {
        //   if (data["ok"]) {
        //     return data;
        //   } else {
        //     errorMessage("Gagal mengambil data profile", "${data["message"]}");
        //     return null;
        //   }
        // } else {
        //   // showLoading();
        //   // var responseLogout = logout();
        //   // if (responseLogout != null) {
        //   //   GetStorage().remove("token");
        //   //   Get.off(() => LoginView());
        //   //   onLoadingDismiss();
        //   //   errorMessage("Token expired", "${data["message"]}");
        //   // } else {
        //   //   onLoadingDismiss();
        //   //   errorMessage("Token expired", "${data["message"]}");
        //   // }
        //   return null;
        // }
      } else {
        errorMessage("Gagal mengambil data profile", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data profile", "$e");
      return null;
    }
  }
  Future createActivity(
      String startDate,
      String endDate,
      String rekan,
      double lat,
      double lng,
      String namaKegiatan,
      String detail,
      int idJenisKegiatan,
      File imageFile) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      final formData = FormData({
        'nrp': username,
        'waktu_kegiatan': startDate,
        'waktu_selesai': endDate,
        'daftar_rekan': rekan,
        'lat': lat,
        'lng': lng,
        'nama_kegiatan': namaKegiatan,
        'detail': detail,
        'id_jenis_kegiatan': idJenisKegiatan,
        'dokumentasi':
        MultipartFile(imageFile, filename: imageFile.path.split('/').last),
      });

      if (token != null) {
        final response = await post('$urlApi/kegiatan/submit', formData,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data createActivity : $data");

        if (data["ok"]) {
          return data;
        } else {
          errorMessage("Gagal Membuat Kegiatan", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal Membuat Kegiatan", "Token kosong");

        return null;
      }
    } catch (e) {
      errorMessage("Gagal Membuat Kegiatan", "$e");
      return null;
    }
  }

  Future fetchDataDetailKegiatan(int id) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = '$urlApi/api/activities/$id';

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data detail kegiatan : $data");

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
        errorMessage("Gagal mengambil data kegiatan", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data kegiatan", "$e");
      return null;
    }
  }
  Future updateKegiatan(
      int idKegiatan, String detail, File? dokumentasi) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      final formData;

      print("dokumentasi:$dokumentasi");

      if (dokumentasi != null) {
        print("dokumentasi 1 : $dokumentasi");
        formData = FormData({
          "nrp": username,
          "id_kegiatan": idKegiatan,
          "detail": detail,
          'dokumentasi': MultipartFile(dokumentasi,
              filename: dokumentasi!.path.split('/').last),
        });
      } else {
        print("dokumentasi 2 : $dokumentasi");
        formData = FormData({
          "nrp": username,
          "id_kegiatan": idKegiatan,
          "detail": detail,
        });
      }

      if (token != null) {
        final response = await post('$urlApi/kegiatan/update', formData,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data update kegiatan : $data");

        if (data["ok"]) {
          return data;
        } else {
          errorMessage("Gagal update kegiatan", "${data["message"]}");
          print("update kegiatan: ${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal update kegiatan", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Terjadi kesalahan", "Gagal update kegiatan");

      return null;
    }
  }
  Future fetchJenisKegiatan() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      if (token != null) {
        final response = await get('$urlApi/kegiatan/jenis?nrp=$username',
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetch JenisKegiatan : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage(
                "Gagal mengambil list jenis kegiatan", "${data["message"]}");
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
        errorMessage("Gagal mengambil list jenis kegiatan", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil list jenis kegiatan", "$e");
      return null;
    }
  }


}