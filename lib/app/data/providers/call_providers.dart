import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/providers/auth_providers.dart';
import 'package:talabang_mandau/app/env/global_var.dart';
import 'package:talabang_mandau/app/modules/login/views/login_view.dart';

class CallProviders extends GetConnect{
  Future getSessionId() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      if (token != null) {
        final response = await get('$urlApi/api/vidcall/session',
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;
        if (response.isOk) {
          print(data);
          return data;
        } else {
          showLoading();
          var responseLogout = await AuthProvider().logout();
          if (responseLogout != null) {
            GetStorage().remove("token");
            Get.off(() => LoginView());
            onLoadingDismiss();
            errorMessage("Token expired", "${data["message"]}");
          } else {
            onLoadingDismiss();
            errorMessage("Token expired", "${data["message"]}");
          }
          return null;
        }
      } else {
        errorMessage("Gagal mengambil list Session Id", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Gagal mengambil list Session Id", "$e");
      return null;
    }
  }
  Future createSession() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      if (token != null) {
        final response = await post('$urlVidcall/api/sessions', {
          "customSessionId": "SessionTest",
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
      final username = await box.read("username");

      if (token != null) {
        final response =
        await post('$urlVidcall/api/sessions/$sessionId/connections', {
          "customSessionId": "SessionTest",
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


}