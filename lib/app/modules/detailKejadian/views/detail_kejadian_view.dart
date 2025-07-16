import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/editKejadian/views/edit_kejadian_view.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/detail_kejadian_controller.dart';

class DetailKejadianView extends GetView<DetailKejadianController> {
  DetailKejadianView({super.key});
  DetailKejadianController controller = Get.put(DetailKejadianController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: CText(
            "Detail Kejadian",
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
          () => controller.isDetailKejadianExist.value
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
                                Icons.troubleshoot,
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
                                  "Kejadian",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKejadian!.kejadian ??
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
                                Icons.location_pin,
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
                                  "Lokasi",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKejadian!.lokasi ??
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
                                  "Keterangan",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKejadian!.keterangan ??
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
                                  "Waktu Kejadian",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKejadian!.waktuKejadian
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
                                Icons.downloading_rounded,
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
                                  "Status",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKejadian!.status ??
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
                                    controller.dataDetailKejadian!.kesatuan ??
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
                                              "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${controller.dataDetailKejadian!.dokumentasi}",
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
                                      "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${controller.dataDetailKejadian!.dokumentasi}",
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
                                Icons.history,
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
                                  "Diupdate Pada",
                                  fontSize: 12,
                                  color: Color(0xFFACACAC),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 124,
                                  child: CText(
                                    controller.dataDetailKejadian!.updatedAt
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
                                    controller.dataDetailKejadian!.namaPersonil,
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
                          "Log Kejadian",
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
                                "Belum ada log kejadian.",
                                fontSize: 14,
                                color: Colors.grey,
                              )),
                        SizedBox(height: 24),

                        SecondaryButton(
                          text: "Update Data",
                          onTap: () => Get.to(() => EditKejadianView(),
                              arguments: {
                                "detailKejadian": controller.dataDetailKejadian
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
