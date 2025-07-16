import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/absensi/controllers/absensi_controller.dart';
import 'package:talabang_mandau/app/modules/selectLocation/views/select_location_view.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

class AbsensiView extends GetView<AbsensiController> {
  AbsensiView({super.key});
  @override
  AbsensiController controller = Get.put(AbsensiController());

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    controller.getDataProfile();

    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: CText(
          "Absensi",
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        actions: [
          SizedBox(
            height: 48,
            child: Image.asset(
              "assets/icon/logo_telabang_icon.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Tambahkan form key di sini
          child: Container(
            margin: const EdgeInsets.all(12.0),
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.typeAbsensi.value.isEmpty
                          ? null
                          : controller.typeAbsensi.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.access_time),
                        labelText: 'Pilih Tipe Absensi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      items: controller.listTypeAbsensi
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Type Absensi wajib dipilih';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 24),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.lokasi.value.isEmpty
                          ? null
                          : controller.lokasi.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        labelText: 'Pilih Lokasi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      items: controller.listLokasi
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.lokasi.value = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lokasi wajib dipilih';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 24),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.kondisi.value.isEmpty
                          ? null
                          : controller.kondisi.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.health_and_safety),
                        labelText: 'Pilih Kondisi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      items: controller.listKondisi
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.kondisi.value = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kondisi wajib dipilih';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 24),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.jenisDinas.value.isEmpty
                          ? null
                          : controller.jenisDinas.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.work),
                        labelText: 'Pilih Jenis Dinas',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      items: controller.listJenisDinas
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width - 190,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.jenisDinas.value = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis Dinas wajib dipilih';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 24),
                koordinatLokasi(context),
                SizedBox(height: 24),
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.showImagePicker(context),
                    child: Container(
                      height: 100,
                      width: MediaQuery.sizeOf(context).width,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Color(0xFFC4C4C4),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: controller.dokumentasi.value.isEmpty
                          ? Center(
                              child: Icon(Icons.camera_alt),
                            )
                          : Image.file(
                              File(controller.dokumentasi.value),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                PrimaryButton(
                  text: "Kirim",
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        controller.dokumentasi.isNotEmpty) {
                      controller.sendAttendance();
                    } else {
                      Get.snackbar("Error", "Form tidak valid");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget koordinatLokasi(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        // controller.checkLocationPermission();
        Get.to(() => SelectLocationView(), arguments: {
          'page': 'absensi',
          'lat': controller.latitude.value,
          'lng': controller.longitude.value
        });
      },
      controller: controller.koordinatController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.location_pin),
        labelText: 'Tentukan Koordinat Lokasi',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tolong isi koordinat';
        }
        return null;
      },
    );
  }
}
