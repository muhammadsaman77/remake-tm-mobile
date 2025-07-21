import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/kegiatanDetail.dart';
import 'package:talabang_mandau/app/data/kejadianDetail.dart';
import 'package:talabang_mandau/app/data/providers/incident_provider.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/app/modules/detailKejadian/controllers/detail_kejadian_controller.dart';

class EditKejadianController extends GetxController {
  //TODO: Implement EditKejadianController
  final incidentProvider = IncidentProvider();
  TextEditingController detailController = TextEditingController();
  TextEditingController koordinatController = TextEditingController();

  String dokumentUrl = "";
  File? dokumentFile;

  List listStatusKejadian = ["diproses", "selesai"];
  RxString statusKejadian = "".obs;

  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  var dataArguments = Get.arguments;
  KejadianDetail? dataDetailKejadian;

  @override
  void onInit() {
    super.onInit();
    dataDetailKejadian = dataArguments["detailKejadian"];
    print("dataDetailKejadian:$dataDetailKejadian");

    detailController.text = dataDetailKejadian!.keterangan;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
      errorMessage("Gagal mengambil Image.");
    }
  }

  setImage(XFile result) async {
    if (result != null) {
      dokumentUrl = result.path;
      dokumentFile = File(result.path);
      print("result: ${result.path}");
      update();
      onLoadingDismiss();
      successMessage(Get.context, "Berhasil mengambil gambar.");
    } else {
      onLoadingDismiss();
      errorMessage("Gagal mengambil gambar.");
    }
  }

  updateKegiatan() async {
    showLoading();
    var response = await incidentProvider.updateKejadian(
        dataDetailKejadian!.id,
        detailController.text,
        dokumentFile,
        statusKejadian.value,
        lat.value,
        lng.value);

    print("response:$response");

    if (response != null) {
      if (response["success"]) {
        DetailKejadianController detailKejadianController =
            Get.put(DetailKejadianController());
        await detailKejadianController.fetchDataDetailKejadian();

        onLoadingDismiss();
        Get.back();
        successMessage(Get.context, response["message"]);
      } else {
        onLoadingDismiss();
        errorMessage("Terjadi kesalahan", response["message"]);
      }
    }
  }
}
