import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/select_location_controller.dart';

class SelectLocationView extends GetView<SelectLocationController> {
  SelectLocationView({super.key});
  SelectLocationController controller = Get.put(SelectLocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: CText(
            "Pilih Lokasi",
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
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              onMapCreated: controller.setMapController,
              zoomGesturesEnabled: true, // Aktifkan zoom
              scrollGesturesEnabled: true, // Aktifkan scroll
              rotateGesturesEnabled: true, // Aktifkan rotasi
              tiltGesturesEnabled: true, // Aktifkan tilt
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  controller.latitude.value,
                  controller.longitude.value,
                ),
                zoom: 12,
              ),
              onCameraMove: (CameraPosition position) {
                controller.centerPosition =
                    position.target; // Update posisi tengah layar
                controller.latitude.value = position.target.latitude;
                controller.longitude.value = position.target.longitude;
                print("latitude:${controller.latitude.value}");
                print("longitdue:${controller.longitude.value}");
              },
            ),
          ),
          Center(
            child: Icon(
              Icons.location_on,
              size: 50,
              color: Colors.red,
            ),
          ),
          Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.checkLocationPermission(),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(Icons.location_searching_outlined,
                              color: Colors.white),
                        )),
                  ),
                  GestureDetector(
                    onTap: () => controller.saveLocation(),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: CText("Simpan Lokasi",
                              fontSize: 16, color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    width: 56,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
