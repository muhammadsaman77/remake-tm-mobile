import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/env/global_var.dart';

class AuthProvider extends GetConnect{
  Future login(String username, String password, String fcmToken) async {
      try {
        final response = await post(
          '$urlApi/api/login',
          {"email": username, "password": password,'fcm_token':fcmToken,"client_id":clientId,"client_secret":clientSecret},
          headers: {"accept":"application/json"}
        );
        var data = response.body;

        if (response.isOk) {
          return data;
        } else {
          errorMessage("Login gagal", "${data["message"]}");
          return null;
        }
      } catch (e) {
        errorMessage("Login gagal", "$e");
        return null;
      }
    }
  Future logout() async {
    GetStorage box = GetStorage();

    try {
      final token = await box.read("token");
      final username = await box.read("username");

      if (token != null) {
        final response = await post('$urlApi/logout', {"username": username},
            headers: {'Authorization': "bearer $username $token"});
        var data = response.body;

        print("data logout : $data");

        if (data["ok"]) {
          return data;
        } else {
          errorMessage("Logout gagal", "${data["message"]}");
          return null;
        }
      } else {
        errorMessage("Logout gagal", "Token kosong");
        return null;
      }
    } catch (e) {
      errorMessage("Login gagal", "$e");
      return null;
    }
  }

}