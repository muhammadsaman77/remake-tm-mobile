import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/env/global_var.dart';
import 'package:talabang_mandau/app/modules/login/views/login_view.dart';

class ServiceProvider extends GetConnect {

  Future sendLocation(double lat, double lng) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");

      if (token != null) {
        final response = await post('$urlApi/api/update-user-loc',
            {"lat": lat, "lng": lng},
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data sendLocation : $data");

        if (data["ok"]) {
          return data;
        } else {
          print("sendLocation: ${data["message"]}");
          return null;
        }
      } else {
        print("token is null");
        return null;
      }
    } catch (e) {
      print("sendLocation: $e");
      return null;
    }
  }




  Future fetchJenisDinas() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");

      if (token != null) {
        final response = await get('$urlApi/api/dinas-types',
            headers: {
          'Accept':"Application/json",
          'Authorization': "Bearer $token"});
        var data = response.body;

        print("data fetchJenisDinas : $data");

        if (data["success"] != null) {
          if (data["success"]) {
            return data;
          } else {
            errorMessage(
                "Gagal mengambil list jenis dinas", "${data["message"]}");
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
        errorMessage("Gagal mengambil list jenis dinas", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil list jenis dinas", "$e");
      return null;
    }
  }




  Future attendance(
      String typeAbsensi,
      String lokasi,
      String kondisi,
      double lat,
      double lng,
      double acc,
      int jenisDinas,
      File imageFile) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");


      final formData = FormData({

        'type_absensi': typeAbsensi,
        'lokasi': lokasi,
        'kondisi': kondisi,
        'lat': lat,
        'lng': lng,
        'acc': acc,
        'jenis_dinas': jenisDinas,
        'dokumentasi':
            MultipartFile(imageFile, filename: imageFile.path.split('/').last),
      });

      if (token != null) {
        final response = await post('$urlApi/api/attendances', formData,
            headers: {'Authorization': "Bearer $token","Accept":"application/json"});
        var data = response.body;

        print("data attendance : $data");

        if (data["success"]) {
          return data;
        } else {
          errorMessage("Gagal Absensi", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal Absensi", "Token kosong");

        return null;
      }
    } catch (e) {
      errorMessage("Gagal Absensi", "$e");
      return null;
    }
  }



  Future fetchDataProfile() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");

      if (token != null) {
        final response = await get('$urlApi/api/profiles',
            headers: {'Authorization': "Bearer $token"});
        var data = response.body;

        print("data fetchDataProfile : $data");

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
        errorMessage("Gagal mengambil data profile", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data profile", "$e");
      return null;
    }
  }







  Future fetchDataBeatPolygon() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = '$urlApi/get-beat?nrp=$username';

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchDataBeatPolygon : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage(
                "Gagal mengambil data polygon beat", "${data["message"]}");
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
        errorMessage("Gagal mengambil data polygon beat", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data polygon beat", "$e");
      return null;
    }
  }







}
