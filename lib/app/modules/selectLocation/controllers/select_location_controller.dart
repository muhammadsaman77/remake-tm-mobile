import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talabang_mandau/app/components/dialog.dart';
import 'package:talabang_mandau/app/components/loading.dart';
import 'package:talabang_mandau/app/modules/absensi/controllers/absensi_controller.dart';
import 'package:talabang_mandau/app/modules/createKegiatan/controllers/create_kegiatan_controller.dart';
import 'package:talabang_mandau/app/modules/createKejadian/controllers/create_kejadian_controller.dart';
import 'package:talabang_mandau/app/modules/editKejadian/controllers/edit_kejadian_controller.dart';

class SelectLocationController extends GetxController {
  //TODO: Implement SelectLocationController

  final count = 0.obs;

  var dataArguments = Get.arguments;

  LatLng? centerPosition;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxDouble acc = 0.0.obs;
  late GoogleMapController mapController;

  String page = "";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(
      Duration(seconds: 1),
      () => handleArguments(dataArguments),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  void handleArguments(Map<String, dynamic>? dataArguments) {
    if (dataArguments != null) {
      double latArgument = dataArguments["lat"] ?? 0.0;
      double lngArgument = dataArguments["lng"] ?? 0.0;

      page = dataArguments["page"];

      double lat = latArgument;
      double lng = lngArgument;

      if (lat != 0.0 && mapController != null) {
        latitude.value = lat;
        longitude.value = lng;
        updateLocation(latitude.value, longitude.value);
      } else {
        checkLocationPermission();
      }
    } else {
      checkLocationPermission();
    }
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

  void saveLocation() {
    if (page == "absensi") {
      AbsensiController absensiController = Get.put(AbsensiController());

      absensiController.latitude.value = latitude.value;
      absensiController.longitude.value = longitude.value;
      absensiController.koordinatController.text =
          "${latitude.value},${longitude.value}";
      Get.back();
    } else if (page == "kegiatan") {
      CreateKegiatanController createKegiatanController =
          Get.put(CreateKegiatanController());

      createKegiatanController.lat.value = latitude.value;
      createKegiatanController.lng.value = longitude.value;
      createKegiatanController.koordinatController.text =
          "${latitude.value},${longitude.value}";
      Get.back();
    } else if (page == "edit kejadian") {
      EditKejadianController editKejadianController =
          Get.put(EditKejadianController());

      editKejadianController.lat.value = latitude.value;
      editKejadianController.lng.value = longitude.value;
      editKejadianController.koordinatController.text =
          "${latitude.value},${longitude.value}";
      Get.back();
    } else if (page == "create kejadian") {
      CreateKejadianController createKejadianController =
          Get.put(CreateKejadianController());

      createKejadianController.lat.value = latitude.value;
      createKejadianController.lng.value = longitude.value;
      createKejadianController.koordinatController.text =
          "${latitude.value},${longitude.value}";
      Get.back();
    }
  }
}
