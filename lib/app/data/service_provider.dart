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
      final username = await box.read("username");

      if (token != null) {
        final response = await post('$urlApi/update-user-loc',
            {"nrp": username, "lat": lat.toString(), "lng": lng.toString()},
            headers: {'Authorization': "bearer $username $token"});
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

  Future fetchJenisDinas() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      if (token != null) {
        final response = await get('$urlApi/get-jenis-dinas',
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchJenisDinas : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
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

  Future fetchJenisLokasi() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      if (token != null) {
        final response = await get('$urlApi/lokasi-vital/jenis',
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchJenisLokasi : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
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

  Future fetchJenisKejadian() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      if (token != null) {
        final response = await get('$urlApi/kejadian/jenis?nrp=$username',
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchJenisKejadian : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage(
                "Gagal mengambil list jenis kejadian", "${data["message"]}");
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
        errorMessage("Gagal mengambil list jenis kejadian", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil list jenis kejadian", "$e");
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
      String jenisDinas,
      File imageFile) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      final formData = FormData({
        'nrp': username,
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
        final response = await post('$urlApi/absensi/submit', formData,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data attendance : $data");

        if (data["ok"]) {
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

  Future createIncident(String date, double lat, double lng, String lokasi,
      String keterangan, int idJenisKejadian, File imageFile) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      final formData = FormData({
        'nrp': username,
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
        final response = await post('$urlApi/kejadian/submit', formData,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data createIncident : $data");

        if (data["ok"]) {
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

  Future fetchDataProfile() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      if (token != null) {
        final response = await get('$urlApi/user-profile?username=$username',
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchDataProfile : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage("Gagal mengambil data profile", "${data["message"]}");
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
        errorMessage("Gagal mengambil data profile", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data profile", "$e");
      return null;
    }
  }

  Future fetchDataListKejadian(String status, int durasi) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = "";

      if (status == "SELESAI") {
        url =
            '$urlApi/kejadian/list?nrp=$username&status=$status&durasi=$durasi';
      } else {
        url = '$urlApi/kejadian/list?nrp=$username&status=$status';
      }

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchDataListKejadian : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage(
                "Gagal mengambil data list kejadian", "${data["message"]}");
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
        errorMessage("Gagal mengambil data list kejadian", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data list kejadian", "$e");
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

  Future fetchDataListKegiatan(String status, int durasi) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = "";

      if (status == "Semua") {
        url =
            '$urlApi/kegiatan/list?nrp=$username&status=$status&durasi=$durasi';
      } else {
        url = '$urlApi/kegiatan/list?nrp=$username&status=$status';
      }

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchDataProfile : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage("Gagal mengambil data profile", "${data["message"]}");
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
        errorMessage("Gagal mengambil data profile", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil data profile", "$e");
      return null;
    }
  }

  Future fetchDataListLokasi(int idJenis) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = '$urlApi/lokasi-vital/list?id_jenis=$idJenis';

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data fetchDataListLokasi : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
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

  Future fetchDataDetailKegiatan(int id) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = '$urlApi/kegiatan/detail?id_kegiatan=$id';

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data detail kegiatan : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage("Gagal mengambil data kegiatan", "${data["message"]}");
            return null;
          }
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

  Future fetchDataDetailKejadian(int id) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      print("username: $username");

      String url = '$urlApi/kejadian/detail?id_kejadian=$id';

      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data detail kejadian : $data");

        if (data["ok"] != null) {
          if (data["ok"]) {
            return data;
          } else {
            errorMessage("Gagal mengambil data kejadian", "${data["message"]}");
            return null;
          }
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

  // @override
  // void onInit() {
  //   httpClient.baseUrl = 'YOUR-API-URL';
  // }
}
