import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/providers/auth_providers.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/modules/login/views/login_view.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: CText(
              "Profile",
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
            ]),
        body: SingleChildScrollView(
          child: GetBuilder<ProfileController>(
              init: ProfileController(),
              builder: (_) {
                return Container(
                  margin: const EdgeInsets.all(24.0),
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
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: primaryColor,
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              CText(
                                controller.dataProfile != null
                                    ? controller.dataProfile!.nrp
                                    : "",
                                color: Colors.black,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            "Kesatuan",
                            fontSize: 12,
                            color: Color(0xFFACACAC),
                          ),
                          CText(
                            controller.dataProfile != null
                                ? controller.dataProfile!.kesatuan.kesatuan
                                : "-",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            "Status Dinas",
                            fontSize: 12,
                            color: Color(0xFFACACAC),
                          ),
                          CText(
                            controller.dataProfile?.statusDinasKegiatan ?? "-"   ,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        onTap: () {
                          // Get.to(() => DetailNewsView());
                        },
                        title: CText(
                          "Bantuan",
                          fontSize: 14,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 16,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        title: CText(
                          "App Version",
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        trailing: CText(
                          "V. 1.0.0",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        onTap: () {
                          confirmMessage(
                            context,
                            "Konfirmasi Logout",
                            "Apakah Anda yakin ingin logout?",
                            () async {
                              showLoading();
                              // var responseLogout = AuthProvider().logout();

                              // print("responseLogout: $responseLogout");

                              // if (responseLogout != null) {
                                GetStorage().remove("token");
                                GetStorage().remove("userData");
                                Get.off(() => LoginView());
                                onLoadingDismiss();
                              // } else {
                              //   onLoadingDismiss();
                              // }
                            },
                          );
                        },
                        title: CText(
                          "Logout",
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        trailing: Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
