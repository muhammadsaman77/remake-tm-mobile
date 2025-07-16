import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/beat_controller.dart';

class BeatView extends GetView<BeatController> {
  BeatView({super.key});
  BeatController controller = Get.put(BeatController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LatLng>>(
      future: controller.fetchPolygonPoints(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading polygon data"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No polygon data available"));
        }

        final polygonPoints = snapshot.data!;
        final polygonCenter = controller.getPolygonCenter(polygonPoints);

        return Scaffold(
          backgroundColor: Color(0xFFF6F6F6),
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: CText(
                "BEAT",
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
          body: GoogleMap(
            onMapCreated: controller.setMapController,
            zoomGesturesEnabled: true, // Aktifkan zoom
            scrollGesturesEnabled: true, // Aktifkan scroll
            rotateGesturesEnabled: true, // Aktifkan rotasi
            tiltGesturesEnabled: true, // Aktifkan tilt
            initialCameraPosition: CameraPosition(
              target: polygonCenter, // Focus on center of polygon
              zoom: 12,
            ),

            polygons: {
              Polygon(
                polygonId: PolygonId("beat_area"),
                points: polygonPoints,
                strokeWidth: 2,
                strokeColor: Colors.blue,
                fillColor: Colors.blue.withOpacity(0.2),
              ),
            },
          ),
        );
      },
    );
  }
}
