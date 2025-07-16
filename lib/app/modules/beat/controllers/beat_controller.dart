import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';

class BeatController extends GetxController {
  //TODO: Implement BeatController

  final count = 0.obs;

  LatLng? centerPosition;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxDouble acc = 0.0.obs;
  late GoogleMapController mapController;

  String page = "";

  final List<LatLng> polygonPoints = [
    LatLng(-1.2735677488207282, 116.80627053839122),
    LatLng(-1.2700651362990705, 116.81097875076846),
    LatLng(-1.2726257698813466, 116.81254049702169),
    LatLng(-1.2560752886143707, 116.81847513345072),
    LatLng(-1.2536395485325678, 116.83802819654156),
    LatLng(-1.2624456750062032, 116.8395899427948),
    LatLng(-1.2671297726936803, 116.83696620908933),
    LatLng(-1.2765603969784594, 116.83815313624181),
    LatLng(-1.28037010957695, 116.8116659197865),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<LatLng>> fetchPolygonPoints() async {
    // Simulated API call
    final response = await ServiceProvider()
        .fetchDataBeatPolygon(); // Assuming this is implemented in the controller

    if (response != null &&
        response["data"] != null &&
        response["data"]["beat_poly_detail"] != null) {
      return (response["data"]["beat_poly_detail"] as List)
          .map<LatLng>((point) => LatLng(point['lat'], point['lng']))
          .toList();
    } else {
      return [];
    }
  }

  // Calculate center of polygon
  LatLng getPolygonCenter(List<LatLng> polygonPoints) {
    double latitudeSum = 0;
    double longitudeSum = 0;
    for (var point in polygonPoints) {
      latitudeSum += point.latitude;
      longitudeSum += point.longitude;
    }
    return LatLng(latitudeSum / polygonPoints.length,
        longitudeSum / polygonPoints.length);
  }

  void increment() => count.value++;

  // --------- Location Permission Check --------- //

  Future<void> checkLocationPermission() async {
    showLoading();
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await requestLocationPermission();
    } else if (permission == LocationPermission.deniedForever) {
      // Handle case where user permanently denied location permission
      print('Location permission is permanently denied');
    } else {
      // Permission already granted, get location
      await getLocation();
    }
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle case where user denied location permission
      print('Location permission is denied');
    } else if (permission == LocationPermission.deniedForever) {
      // Handle case where user permanently denied location permission
      print('Location permission is permanently denied');
    } else {
      // Permission granted, get location
      await getLocation();
    }
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("position: $position");
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      acc.value = position.accuracy; // Mengambil keakuratan posisi
      updateLocation(latitude.value, longitude.value);
      onLoadingDismiss();
      update();
    } catch (e) {
      onLoadingDismiss();
      print('Error: $e');
    }
  }

  // --------- Location Permission Check --------- //

  void updateLocation(double newLat, double newLng) {
    latitude.value = newLat;
    longitude.value = newLng;

    // Geser kamera
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(newLat, newLng),
          zoom: 20, // Zoom level diatur ke 20
        ),
      ),
    );
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }
}
