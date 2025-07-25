import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talabang_mandau/app/data/kegiatanItem.dart';
import 'package:talabang_mandau/app/data/providers/activity_provider.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';

class KegiatanController extends GetxController {

  List<String> listTypeFilter = ["Aktif", "Semua"];
  final activityProvider = ActivityProvider();

  RxString typeFilter = 'Aktif'.obs;
  RxInt typeDuration = 3.obs;

  List<Kegiatan> listKegiatan = [];
  RxBool isListKegiatanExist = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchDataListKegiatan();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchDataListKegiatan() async {
    isListKegiatanExist.value = false;

    var response = await activityProvider.fetchDataListKegiatan(typeFilter.value, typeDuration.value);

    print("response:$response");

    if (response != null) {
      if (response["payload"]!=null) {
        listKegiatan = (response["payload"] as List<dynamic>)
            .map((item) => Kegiatan.fromJson(item as Map<String, dynamic>))
            .toList();

        print("listKegiatan:${listKegiatan[0].namaKegiatan}");
        isListKegiatanExist.value = true;
        update();
      } else {
        isListKegiatanExist.value = true;
        update();
      }
    }
  }

  String convertTime(originalDate) {
    // Parse string ke DateTime

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
