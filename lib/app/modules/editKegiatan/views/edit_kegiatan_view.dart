import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/edit_kegiatan_controller.dart';

class EditKegiatanView extends GetView<EditKegiatanController> {
  EditKegiatanView({super.key});
  EditKegiatanController controller = Get.put(EditKegiatanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: CText(
            "Update Kegiatan",
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
                SizedBox(height: 24),
                CText(
                  "Dokumentasi",
                  fontSize: 16,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 6,
                ),
                GetBuilder<EditKegiatanController>(
                    init: EditKegiatanController(),
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
                          child: controller.dokumentUrl == null
                              ? Center(
                                  child: Icon(Icons.camera_alt),
                                )
                              : controller.dokumentFile != null
                                  ? Image.file(
                                      controller.dokumentFile!,
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Image.network(
                                      "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${controller.dataDetailKegiatan!.dokumentasi}",
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      );
                    }),
                Spacer(),
                PrimaryButton(text: "Simpan", onTap: ()=> controller.updateKegiatan())
              ],
            ),
          ),
        ));
  }
}
