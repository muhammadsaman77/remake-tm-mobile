import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/editKegiatan/views/edit_kegiatan_view.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/detail_kegiatan_controller.dart';

class DetailKegiatanView extends GetView<DetailKegiatanController> {
  DetailKegiatanView({super.key});
  DetailKegiatanController controller = Get.put(DetailKegiatanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: CText(
            "Detail Kegiatan",
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
        body: Obx(
          () => controller.isDetailKegiatanExist.value
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.event,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Nama Kegiatan",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller
                                            .dataDetailKegiatan!.namaKegiatan ??
                                        "-",
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.task,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Detail",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKegiatan!.detail ??
                                        "-",
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.access_time,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Waktu Kegiatan",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKegiatan!.waktuKegiatan
                                            .toString() ??
                                        "-",
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.access_time,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Waktu Selesai",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKegiatan!.waktuSelesai
                                            .toString() ??
                                        "-",
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.group,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Daftar Rekan",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller
                                            .dataDetailKegiatan!.daftarRekan ??
                                        "-",
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.route,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Rute Patroli",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller
                                            .dataDetailKegiatan!.rutePatroli ??
                                        "-",
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.image,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Dokumentasi",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Tampilkan modal fullscreen
                                    Get.dialog(
                                      Dialog(
                                        insetPadding: const EdgeInsets.all(10),
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${controller.dataDetailKegiatan!.dokumentasi}",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100,
                                    width:
                                        MediaQuery.sizeOf(context).width - 100,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFC4C4C4),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Image.network(
                                      "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${controller.dataDetailKegiatan!.dokumentasi}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.location_city,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Kesatuan",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKegiatan!.kesatuan,
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.person,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Personil",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKegiatan!.namaPersonil,
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Icon(
                                Icons.event_note,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CText(
                                  "Jenis Kegiatan",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller
                                        .dataDetailKegiatan!.jenisKegiatan,
                                    fontSize: 14,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        // Bagian Data Log
                        CText(
                          "Log Kegiatan",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        SizedBox(height: 12),
                        Obx(() => controller.dataLog.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.dataLog.length,
                                itemBuilder: (context, index) {
                                  final log = controller.dataLog[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 6,
                                          offset:
                                              Offset(0, 3), // Shadow position
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CText(
                                                "Detail",
                                                fontSize: 12,
                                                color: Color(0xFFACACAC),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width -
                                                        124,
                                                child: CText(
                                                  log["detail"] ?? "-",
                                                  fontSize: 14,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CText(
                                                "Dokumentasi",
                                                fontSize: 12,
                                                color: Color(0xFFACACAC),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              log["dokumentasi"] != null
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        // Tampilkan modal fullscreen
                                                        Get.dialog(
                                                          Dialog(
                                                            insetPadding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                child: Image
                                                                    .network(
                                                                  "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${log["dokumentasi"]}",
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 100,
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width -
                                                                100,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC4C4C4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                        ),
                                                        child: Image.network(
                                                          "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${log["dokumentasi"]}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : CText("-")
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CText(
                                                "Dibuat oleh",
                                                fontSize: 12,
                                                color: Color(0xFFACACAC),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width -
                                                        124,
                                                child: CText(
                                                  "${log["nama"]} pada ${log["created_at"]}",
                                                  fontSize: 14,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : CText(
                                "Belum ada log kegiatan.",
                                fontSize: 14,
                                color: Colors.grey,
                              )),
                        SizedBox(height: 24),

                        SecondaryButton(
                          text: "Update Data",
                          onTap: () => Get.to(() => EditKegiatanView(),
                              arguments: {
                                "detailKegiatan": controller.dataDetailKegiatan
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
