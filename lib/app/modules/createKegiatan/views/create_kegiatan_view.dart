import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/selectLocation/views/select_location_view.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/create_kegiatan_controller.dart';

class CreateKegiatanView extends GetView<CreateKegiatanController> {
  CreateKegiatanView({super.key});
  CreateKegiatanController controller = Get.put(CreateKegiatanController());
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: CText(
            "Buat Kegiatan",
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
              key: _formKey,
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
                  children: [
                    TextFormField(
                      controller: controller.namaKegiatanController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.event),
                        labelText: 'Nama Kegiatan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Kegiatan belum diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: controller.detailKegiatanController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.task),
                        labelText: 'Detail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Detail belum diisi';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    Obx(() => DropdownButtonFormField<JenisKegiatan>(
                          value: controller.jenisKegiatan == null
                              ? null
                              : controller.jenisKegiatan,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.work),
                            labelText: 'Pilih Jenis Kegiatan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          items: controller.listJenisKegiatan
                              .map((e) => DropdownMenuItem<JenisKegiatan>(
                                    value: e,
                                    child: SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width -
                                                190,
                                        child: Text(
                                          "${e.jenis}",
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            controller.jenisKegiatan = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Jenis Kegiatan wajib dipilih';
                            }
                            return null;
                          },
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: controller.startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.access_time),
                        labelText: 'Waktu Kegiatan Dimulai',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onTap: () => controller.pickDateTime(
                          context, controller.startDateController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Waktu Kegiatan Dimulai belum dipilih';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: controller.endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.access_time),
                        labelText: 'Waktu Kegiatan Selesai',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onTap: () => controller.pickDateTime(
                          context, controller.endDateController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Waktu Kegiatan Selesai belum dipilih';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: controller.partnerController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        labelText: 'Rekan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Rekan belum diisi';
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
                        labelText: 'Koordinat Lokasi Kegiatan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onTap: () => Get.to(() => SelectLocationView(),
                          arguments: {
                            'page': 'kegiatan',
                            'lat': controller.lat.value,
                            'lng': controller.lng.value
                          }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Koordinat Lokasi Kegiatan belum dipilih';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
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
                          child: controller.dokumentasiUrl.value.isEmpty
                              ? Center(
                                  child: Icon(Icons.camera_alt),
                                )
                              : Image.file(
                                  File(controller.dokumentasiUrl.value),
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
                            controller.dokumentasiUrl.isNotEmpty) {
                          controller.createActivity();
                        } else {
                          Get.snackbar("Error", "Form tidak valid");
                        }
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}
