import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/env/global_var.dart';

class DaruratProvider extends GetConnect{
  Future createDarurat(double lat, double lng, double acc)async {
    GetStorage box = GetStorage();
    try {
      final token = await box.read("token");
      final formData = FormData({
        'lat': lat,
        'lng': lng,
        'acc': acc
      });
      if (token != null) {
        final response = await post('$urlApi/api/emergency/', formData,
            headers: {'Authorization': "Bearer $token","Accept":"application/json"});
        var data = response.body;
        print("data darurat : $data");
        print("data createIncident : $data");

        if (response.isOk) {
          return data;
        } else {
          errorMessage("Gagal Membuat darurat", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal Membuat darurat", "Token kosong");

        return null;
      }
    }
    catch (e) {
      errorMessage("Gagal Membuat darurat", "$e");
      return null;
    }
  }}
