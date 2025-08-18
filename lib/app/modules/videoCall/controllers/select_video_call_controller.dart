import 'package:get/get.dart';
import 'package:talabang_mandau/app/data/personilItem.dart';
import 'package:talabang_mandau/app/data/providers/call_providers.dart';
import 'package:talabang_mandau/app/data/providers/personil_provider.dart';
import 'package:talabang_mandau/app/modules/home/controllers/home_controller.dart';

class SelectVideoController extends GetxController{
  final personilProvider = PersonilProvider();
  List<Personil> listPersonil = [];
  RxBool isListPersonilExist = false.obs;
  CallProviders callProvider = CallProviders();


  @override
  void onInit() {
    super.onInit();
    fetchDataListPersonil();
  }
  Future<void> fetchDataListPersonil() async{
    var response = await personilProvider.getListPersonil();
    if (response != null) {
      if (response["payload"]!=null) {
        listPersonil = (response["payload"] as List<dynamic>)
            .map((item) => Personil.fromJson(item as Map<String, dynamic>))
            .toList();

        print("listPersonil:${listPersonil[0].nama}");
        isListPersonilExist.value = true;
        update();
      } else {
        isListPersonilExist.value = true;
        update();
      }
    }
  }
  Future<void> onTapCall(int id, String sessionName)async{
    Get.find<HomeController>().startVidcall(sessionName);
    await callProvider.createNotify(id);


  }
}
