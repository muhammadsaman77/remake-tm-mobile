import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/providers/auth_providers.dart';
import 'package:talabang_mandau/app/env/global_var.dart';
import 'package:talabang_mandau/app/modules/login/views/login_view.dart';

class CallProviders extends GetConnect{
  Future createSession(String sessionName) async {
    GetStorage box = GetStorage();
    try {
      final token = await box.read("token");
      if (token != null) {
        final response = await post('$urlVidcall/api/sessions', {
          "customSessionId": sessionName,
        }, headers: {
          'Content-type': "application/json"
        });
        var data = response.body;

        print("data createSession : $data");

        if (data != null) {
          return data;
        } else {
          errorMessage("Gagal Membuat Session", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal Membuat Session", "Token kosong");

        return null;
      }
    } catch (e) {
      errorMessage("Gagal Membuat Session", "$e");
      print("response: $e");
      return null;
    }
  }
  Future createToken(sessionId) async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");


      if (token != null) {
        final response =
        await post('$urlVidcall/api/sessions/$sessionId/connections', {
          "customSessionId": sessionId,
        }, headers: {
          'Content-type': "application/json"
        });
        var data = response.body;

        print("data createToken : $data");

        if (data != null) {
          return data;
        } else {
          errorMessage("Gagal Membuat Token Vidu", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal Membuat Token Vidu", "Token kosong");

        return null;
      }
    } catch (e) {
      errorMessage("Gagal Membuat Token Vidu", "$e");
      print("response: $e");
      return null;
    }
  }

  Future createNotify(int kesatuanId)async {
    GetStorage box = GetStorage();
    try {
      final token = await box.read("token");
      final formData = FormData({
        'target_kesatuan_id': kesatuanId,
      });
      if (token != null) {
        final response = await post('$urlApi/api/notify-call/', formData,
            headers: {'Authorization': "Bearer $token","Accept":"application/json"});
        var data = response.body;
        print("data notify : $data");
        print("data notify : $data");

        if (response.isOk) {
          return data;
        } else {
          errorMessage("Gagal Membuat notify", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Gagal Membuat notify", "Token kosong");

        return null;
      }
    }
    catch (e) {
      errorMessage("Gagal Membuat notify", "$e");
      return null;
    }
  }
}