import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/modules/beat/views/beat_view.dart';
import 'package:talabang_mandau/app/modules/kegiatan/views/kegiatan_view.dart';
import 'package:talabang_mandau/app/modules/kejadian/views/kejadian_view.dart';
import 'package:talabang_mandau/app/modules/locationVital/views/location_vital_view.dart';
import 'package:talabang_mandau/app/modules/videoCall/screens/prepare_videocall.dart';
import 'package:talabang_mandau/app/modules/videoCall/views/video_call_view.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        confirmMessage(context, "Konfirmasi",
            "Apakah Anda yakin ingin keluar dari aplikasi?", () {
          Get.back(); // Tutup dialog
          SystemNavigator.pop();
        });
        return true;
      },
      child: Scaffold(
          backgroundColor: Color(0xFFF6F6F6),
          body: RefreshIndicator(
            onRefresh: ()async{
              await controller.fetchDataProfile();
              print("=====");
              print(controller.dataProfile!.kesatuan.kesatuan);
              print("=====");
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  GetBuilder<HomeController>(
                      init: HomeController(),
                      builder: (_) {
                        return Container(
                          padding: EdgeInsets.only(left: 24, right: 24, top: 64),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(color: primaryColor),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(100)),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      controller.dataProfile != null
                                          ? controller.dataProfile!.photo != null
                                              ? "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/${controller.dataProfile!.photo!}"
                                              : "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/photos/default-user-photo.png"
                                          : "https://dsn-appdev.web.id/tm-monitoring/dokumentasi/photos/default-user-photo.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CText(
                                        controller.dataProfile != null
                                            ? controller.dataProfile!.nama
                                            : "",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      CText(
                                        controller.dataProfile != null
                                            ? controller.dataProfile!.nrp
                                            : "",
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.support_agent,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Icon(
                                    Icons.notifications,
                                    size: 24,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              GetBuilder<HomeController>(
                                  init: HomeController(),
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CText(
                                                    "Kesatuan",
                                                    fontSize: 12,
                                                    color: Color(0xFFACACAC),
                                                  ),
                                                  CText(
                                                    controller.dataProfile != null
                                                        ? controller
                                                            .dataProfile!.kesatuan.kesatuan
                                                        : "",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                height: 48,
                                                child: Image.asset(
                                                  "assets/icon/logo_telabang_icon.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CText(
                                                    "Masuk",
                                                    fontSize: 12,
                                                    color: Color(0xFFACACAC),
                                                  ),
                                                  CText(
                                                    controller.dataProfile != null
                                                        ? controller.convertTime(
                                                            controller
                                                                .dataProfile!
                                                                .absensiWaktuDatang)
                                                        : "-.-.-",
                                                    fontSize: 14,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CText(
                                                    "Pulang",
                                                    fontSize: 12,
                                                    color: Color(0xFFACACAC),
                                                  ),
                                                  CText(
                                                    controller.dataProfile != null
                                                        ? controller.convertTime(
                                                            controller
                                                                .dataProfile!
                                                                .absensiWaktuPulang)
                                                        : "-.-.-",
                                                    fontSize: 14,
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 24,
                              ),
                              DottedBorder(
                                color: Colors.white,
                                radius: Radius.circular(12),
                                borderType: BorderType.RRect,
                                dashPattern: [3],
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.work,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                            "Status Dinas",
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          CText(
                                            controller.dataProfile?.statusDinasKegiatan ?? "-"
                                            ,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 48,
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    margin: EdgeInsets.symmetric(horizontal: 24),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            featureCard("Kegiatan", "assets/icon/mobile.png", () {
                              Get.to(() => KegiatanView());
                            }),
                            featureCard("Lapor Kejadian", "assets/icon/file.png",
                                () {
                              Get.to(() => KejadianView());
                            }),
                            featureCard(
                                "Video Call", "assets/icon/video-call.png", () {
                              controller.fetchDataSessions();
                            })
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            featureCard(
                                "Lokasi Vital", "assets/icon/location.png", () {
                              Get.to(() => LocationVitalView());
                            }),
                            featureCard(
                                "HT Gateway", "assets/icon/walkie-talkie.png",
                                () {
                              errorMessage("Coming Soon!",
                                  "Layanan ini akan segera hadir.");
                            }),
                            featureCard("BEAT", "assets/icon/pin.png", () {
                              Get.to(
                                () => BeatView(),
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget featureCard(String label, String assetUrl, VoidCallback function) {
    return InkWell(
      onTap: function,
      child: Container(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 48,
              child: Image.asset(
                assetUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            CText(
              label,
              fontSize: 12,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
