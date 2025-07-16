import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:talabang_mandau/app/data/service_provider.dart';
import 'package:talabang_mandau/firebase_options.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

// --------- Location Permission Check --------- //

double latitude = 0.0;
double longitude = 0.0;

// Fungsi untuk memeriksa dan meminta izin lokasi
Future<void> ensureLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    // Jika izin belum diberikan, minta izin
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Izin lokasi ditolak atau ditolak secara permanen.");
      return; // Keluar jika izin tidak diberikan
    }
  } else if (permission == LocationPermission.deniedForever) {
    print("Izin lokasi ditolak secara permanen.");
    return; // Keluar jika izin ditolak secara permanen
  }
  // Izin sudah diberikan, panggil fungsi getLocation
  await getLocation();
}

Future<void> getLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;

    // Kirim data lokasi ke server
    final token = await GetStorage().read("token");
    print("token: $token");
    if (token != null) {
      await ServiceProvider().sendLocation(latitude, longitude);
    } else {
      print("Token is null");
    }

    // Log untuk debug
    print("Location sent: Lat=$latitude, Lng=$longitude, ${DateTime.now()}");
  } catch (e) {
    print('Error: $e');
  }
}

// --------- Background Service --------- //

Future<void> startTracking(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    await service.setForegroundNotificationInfo(
      title: "Tracking Location",
      content: "Background service is running...",
    );
  }

  Timer.periodic(Duration(minutes: 5), (timer) async {
    await getLocation();
  });
}

initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: startTracking,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: startTracking,
      autoStart: true,
    ),
  );

  service.startService();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background notification
  print("Handling a background message: ${message.messageId}");
}

// --------- Main Function --------- //

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan binding Flutter terinisialisasi
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await GetStorage.init();

  // Pastikan izin lokasi diberikan sebelum memulai background service
  await ensureLocationPermission();
  // await initializeService();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    ),
  );
}
