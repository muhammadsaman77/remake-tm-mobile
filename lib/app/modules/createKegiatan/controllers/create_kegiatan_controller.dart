import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/app/modules/kegiatan/controllers/kegiatan_controller.dart';

class CreateKegiatanController extends GetxController {
  //TODO: Implement CreateKegiatanController

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  TextEditingController koordinatController = TextEditingController();
  TextEditingController namaKegiatanController = TextEditingController();
  TextEditingController detailKegiatanController = TextEditingController();
  File? dokumentasiFile;
  RxString dokumentasiUrl = "".obs;
  RxString idJenisKegiatan = "".obs;
  TextEditingController partnerController = TextEditingController();

  RxList listJenisKegiatan = [].obs;
  JenisKegiatan? jenisKegiatan;

  @override
  void onInit() {
    super.onInit();
    fetchJenisKegiatan();

    log("${GetStorage().read("token")}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchJenisKegiatan() async {
    var response = await ServiceProvider().fetchJenisKegiatan();

    print("response: $response");

    if (response != null) {
      List listData = response["data"];
      for (var i = 0; i < listData.length; i++) {
        listJenisKegiatan.add(
            JenisKegiatan(id: listData[i]["id"], jenis: listData[i]["jenis"]));
      }
    }
  }

  void pickDateTime(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        controller.text =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(combinedDateTime);
      }
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 160,
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Text('Pilih Gambar dari Galeri'),
              ),
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
      errorMessage("Gagal mengambil gambar.");
    }
  }

  setImage(XFile result) async {
    if (result != null) {
      dokumentasiFile = File(result.path);
      print("result: ${result.path}");
      dokumentasiUrl.value = result.path;
      onLoadingDismiss();
      successMessage(Get.context, "Berhasil mengambil gambar.");
    } else {
      onLoadingDismiss();
      errorMessage("Gagal mengambil gambar.");
    }
  }

  createActivity() async {
    showLoading();
    var response = await ServiceProvider().createActivity(
        startDateController.text,
        endDateController.text,
        partnerController.text,
        lat.value,
        lng.value,
        namaKegiatanController.text,
        detailKegiatanController.text,
        jenisKegiatan!.id,
        dokumentasiFile!);

    print("response: $response");

    if (response != null) {
      KegiatanController kegiatanController = Get.put(KegiatanController());
      await kegiatanController.fetchDataListKegiatan();
      Get.back();
      onLoadingDismiss();
      successMessage(Get.context, "${response["message"]}");
    } else {
      onLoadingDismiss();
    }
  }
}

class JenisKegiatan {
  final int id;
  final String jenis;

  JenisKegiatan({
    required this.id,
    required this.jenis,
  });
}
