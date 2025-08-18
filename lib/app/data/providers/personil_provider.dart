import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/env/global_var.dart';

class PersonilProvider extends GetConnect{
  Future getListPersonil() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");


      String url = "$urlApi/api/vidcall";
      if (token != null) {
        final response = await get(url,
            headers: {'Authorization': "Bearer $token",'Accept':"Application/json"});
        var data = response.body;

        print("data fetchDataProfile : $data");
        if (response.isOk){
          return data;
        }else{
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
  }
