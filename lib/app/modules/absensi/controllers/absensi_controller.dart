import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/dataUser.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/app/modules/home/controllers/home_controller.dart';
import 'package:talabang_mandau/app/modules/tabDecider/controllers/tab_decider_controller.dart';

class AbsensiController extends GetxController {
  //TODO: Implement AbsensiController

  GetStorage box = GetStorage();
  List<String> listTypeAbsensi = ["datang", "pulang"];
  List<String> listLokasi = ["Dinas Luar", "Rumah", "Kantor"];
  List<String> listKondisi = ["sehat", "kurang sehat", "sakit"];
  RxList<String> listJenisDinas = <String>[].obs;

  RxString typeAbsensi = ''.obs;
  RxString lokasi = ''.obs;
  RxString kondisi = ''.obs;
  RxString jenisDinas = ''.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxDouble acc = 0.0.obs;
  RxString dokumentasi = "".obs;
  File? dokumentasiFile;

  TextEditingController koordinatController = TextEditingController();
  UserData? dataProfile;

  @override
  void onInit() {
    super.onInit();
    fetchJenisDinas();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDataProfile() {
    if (box.read("userData") != null) {
      dataProfile = UserData.fromJson(box.read("userData"));
      if (dataProfile!.absensiWaktuDatang != null &&
          dataProfile!.absensiWaktuPulang != null) {
        typeAbsensi.value = "";
      } else {
        if (dataProfile!.absensiWaktuDatang != null) {
          typeAbsensi.value = "pulang";
        } else {
          typeAbsensi.value = "datang";
        }
      }
      update();
    }
  }

  fetchJenisDinas() async {
    var responseFetchJenisDinas = await ServiceProvider().fetchJenisDinas();

    print("responseFetchJenisDinas: $responseFetchJenisDinas");

    if (responseFetchJenisDinas != null) {
      List listData = responseFetchJenisDinas["data"];
      for (var i = 0; i < listData.length; i++) {
        listJenisDinas.add(listData[i].toString());
      }
    }
  }

  // --------- Location Permission Check --------- //

  Future<void> checkLocationPermission() async {
    showLoading();
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await requestLocationPermission();
    } else if (permission == LocationPermission.deniedForever) {
      // Handle case where user permanently denied location permission
      print('Location permission is permanently denied');
    } else {
      // Permission already granted, get location
      await getLocation();
    }
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle case where user denied location permission
      print('Location permission is denied');
    } else if (permission == LocationPermission.deniedForever) {
      // Handle case where user permanently denied location permission
      print('Location permission is permanently denied');
    } else {
      // Permission granted, get location
      await getLocation();
    }
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      koordinatController.text = "${latitude.value},${longitude.value}";
      acc.value = position.accuracy; // Mengambil keakuratan posisi

      if (acc.value > 5.0) {
        // Jika keakuratan lebih dari 5 meter, dianggap error
        print(
            'GPS Error: ${acc.value} meters (Accuracy is greater than 5 meters)');
        // errorMessage("GPS kurang akurat, coba kembali.");

        confirmMessage(Get.context, "GPS tidak akurat",
            "Koordinat lokasi saat ini tidak akurat, apakah tetap dengan koordinat ini?",
            () {
          update();
          Get.back();
        });
      } else {
        koordinatController.text = "${latitude.value},${longitude.value}";
      }

      onLoadingDismiss();
      update();
    } catch (e) {
      onLoadingDismiss();
      print('Error: $e');
    }
  }

  // --------- Location Permission Check --------- //

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 80,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Text('Ambil Gambar dari Kamera'),
              ),
              // SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     getImage(ImageSource.gallery);
              //     Navigator.pop(context);
              //   },
              //   child: Text('Pilih Gambar dari Galeri'),
              // ),
            ],
          ),
        );
      },
    );
  }

  XFile? imageFile;

  Future<void> getImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? imageFile =
          await picker.pickImage(source: source, imageQuality: 25);

      if (imageFile != null) {
        showLoading();

        var result = await FlutterImageCompress.compressWithFile(
          imageFile.path,
          minHeight: 720,
        );

        setImage(imageFile);
      }
    } catch (e) {
      print('Error saat mengambil gambar: $e');
      onLoadingDismiss();
      errorMessage("Gagal Mengupload Image.");
    }
  }

  setImage(XFile result) async {
    if (result != null) {
      dokumentasiFile = File(result.path);
      print("result: ${result.path}");
      dokumentasi.value = result.path;
      onLoadingDismiss();
      successMessage(Get.context, "Berhasil ambil gambar.");
    } else {
      onLoadingDismiss();
      errorMessage("Gagal ambil gambar.");
    }
  }

  sendAttendance() async {
    showLoading();
    var responseAttendance = await ServiceProvider().attendance(
        typeAbsensi.value,
        lokasi.value,
        kondisi.value,
        latitude.value,
        longitude.value,
        acc.value,
        jenisDinas.value,
        dokumentasiFile!);

    print("responseAttendance: $responseAttendance");

    if (responseAttendance != null) {
      HomeController homeController = Get.put(HomeController());
      await homeController.fetchDataProfile();

      TabDeciderController tabDeciderController =
          Get.put(TabDeciderController());
      tabDeciderController.changeTab(0);

      typeAbsensi.value = "";
      lokasi.value = "";
      kondisi.value = "";
      jenisDinas.value = "";
      latitude.value = 0.0;
      longitude.value = 0.0;
      koordinatController.clear();
      acc.value = 0.0;
      dokumentasi.value = "";
      onLoadingDismiss();
      successMessage(Get.context, "${responseAttendance["message"]}");
    } else {
      TabDeciderController tabDeciderController =
          Get.put(TabDeciderController());
      tabDeciderController.changeTab(0);

      typeAbsensi.value = "";
      lokasi.value = "";
      kondisi.value = "";
      jenisDinas.value = "";
      latitude.value = 0.0;
      longitude.value = 0.0;
      koordinatController.clear();
      acc.value = 0.0;
      dokumentasi.value = "";
      onLoadingDismiss();
    }
  }
}
