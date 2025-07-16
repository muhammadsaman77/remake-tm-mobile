import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talabang_mandau/app/data/kejadianItem.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';

class KejadianController extends GetxController {
  //TODO: Implement KejadianController

  List<String> listTypeFilter = ["BELUM DITANGANI", "PENANGANAN", "SELESAI"];

  RxString typeFilter = 'BELUM DITANGANI'.obs;
  RxInt typeDuration = 3.obs;

  List<Kejadian> listKejadian = [];
  RxBool isListKejadianExist = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataListKejadian();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchDataListKejadian() async {
    isListKejadianExist.value = false;

    var response = await ServiceProvider()
        .fetchDataListKejadian(typeFilter.value, typeDuration.value);

    print("response:$response");

    if (response != null) {
      if (response["ok"]) {
        listKejadian = (response["data"] as List<dynamic>)
            .map((item) => Kejadian.fromJson(item as Map<String, dynamic>))
            .toList();

        print("listKegiatan:${listKejadian}");
        isListKejadianExist.value = true;
        update();
      } else {
        isListKejadianExist.value = true;
        update();
      }
    }
  }

  convertTime(originalDate) {
    // Parse string ke DateTime
    print("originalDate:$originalDate");
    String formattedDate = "";
    if (originalDate != null) {
      DateTime dateTime = originalDate;

      // Format ke 19/12/2024 14:44
      formattedDate = DateFormat("dd/MM/yy HH:mm").format(dateTime);
    } else {
      formattedDate = "-";
    }

    return formattedDate; // Output: 19/12/2024 14:44
  }
}
