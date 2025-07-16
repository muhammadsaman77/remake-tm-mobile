import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/selectLocation/views/select_location_view.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/edit_kejadian_controller.dart';

class EditKejadianView extends GetView<EditKejadianController> {
  EditKejadianView({super.key});
  EditKejadianController controller = Get.put(EditKejadianController());
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: CText(
            "Update Kejadian",
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            height: MediaQuery.sizeOf(context).height -
                24 -
                AppBar().preferredSize.height,
            width: MediaQuery.sizeOf(context).width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.task),
                      labelText: 'Detail Kegiatan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    controller: controller.detailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Detail Kegiatan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: controller.koordinatController,
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_pin),
                      labelText: 'Koordinat Lokasi Kejadian',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onTap: () => Get.to(() => SelectLocationView(), arguments: {
                      'page': 'edit kejadian',
                      'lat': controller.lat.value,
                      'lng': controller.lng.value
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Koordinat Lokasi Kejadian belum dipilih';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.statusKejadian.value.isEmpty
                            ? null
                            : controller.statusKejadian.value,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.downloading_rounded),
                          labelText: 'Pilih Status Kejadian',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        items: controller.listStatusKejadian
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.statusKejadian.value = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Status Kejadian wajib dipilih';
                          }
                          return null;
                        },
                      )),
                  SizedBox(height: 24),
                  CText(
                    "Dokumentasi",
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GetBuilder<EditKejadianController>(
                      init: EditKejadianController(),
                      builder: (_) {
                        return GestureDetector(
                          onTap: () => controller.showImagePicker(context),
                          child: Container(
                              height: 200,
                              width: MediaQuery.sizeOf(context).width,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: controller.dokumentUrl.isEmpty
                                  ? Center(
                                      child: Icon(Icons.camera_alt),
                                    )
                                  : Image.file(
                                      controller.dokumentFile!,
                                      fit: BoxFit.fitHeight,
                                    )),
                        );
                      }),
                  Spacer(),
                  PrimaryButton(
                      text: "Simpan",
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            controller.dokumentUrl.isNotEmpty) {
                          controller.updateKegiatan();
                        } else {
                          Get.snackbar("Error", "Form tidak valid");
                        }
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
