import 'package:get/get.dart';

import '../modules/HT/bindings/ht_binding.dart';
import '../modules/HT/views/ht_view.dart';
import '../modules/absensi/bindings/absensi_binding.dart';
import '../modules/absensi/views/absensi_view.dart';
import '../modules/beat/bindings/beat_binding.dart';
import '../modules/beat/views/beat_view.dart';
import '../modules/call/bindings/call_binding.dart';
import '../modules/call/views/call_view.dart';
import '../modules/createKegiatan/bindings/create_kegiatan_binding.dart';
import '../modules/createKegiatan/views/create_kegiatan_view.dart';
import '../modules/createKejadian/bindings/create_kejadian_binding.dart';
import '../modules/createKejadian/views/create_kejadian_view.dart';
import '../modules/detailKegiatan/bindings/detail_kegiatan_binding.dart';
import '../modules/detailKegiatan/views/detail_kegiatan_view.dart';
import '../modules/detailKejadian/bindings/detail_kejadian_binding.dart';
import '../modules/detailKejadian/views/detail_kejadian_view.dart';
import '../modules/editKegiatan/bindings/edit_kegiatan_binding.dart';
import '../modules/editKegiatan/views/edit_kegiatan_view.dart';
import '../modules/editKejadian/bindings/edit_kejadian_binding.dart';
import '../modules/editKejadian/views/edit_kejadian_view.dart';
import '../modules/emergency/bindings/emergency_binding.dart';
import '../modules/emergency/views/emergency_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kegiatan/bindings/kegiatan_binding.dart';
import '../modules/kegiatan/views/kegiatan_view.dart';
import '../modules/kejadian/bindings/kejadian_binding.dart';
import '../modules/kejadian/views/kejadian_view.dart';
import '../modules/locationVital/bindings/location_vital_binding.dart';
import '../modules/locationVital/views/location_vital_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/riwayatPatroli/bindings/riwayat_patroli_binding.dart';
import '../modules/riwayatPatroli/views/riwayat_patroli_view.dart';
import '../modules/selectLocation/bindings/select_location_binding.dart';
import '../modules/selectLocation/views/select_location_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tabDecider/bindings/tab_decider_binding.dart';
import '../modules/tabDecider/views/tab_decider_view.dart';
import '../modules/videoCall/bindings/video_call_binding.dart';
import '../modules/videoCall/views/video_call_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI,
      page: () => AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: _Paths.KEGIATAN,
      page: () => KegiatanView(),
      binding: KegiatanBinding(),
    ),
    GetPage(
      name: _Paths.CALL,
      page: () => CallView(),
      binding: CallBinding(),
    ),
    GetPage(
      name: _Paths.HT,
      page: () => HtView(),
      binding: HtBinding(),
    ),
    GetPage(
      name: _Paths.TAB_DECIDER,
      page: () => TabDeciderView(),
      binding: TabDeciderBinding(),
    ),
    GetPage(
      name: _Paths.EMERGENCY,
      page: () => EmergencyView(),
      binding: EmergencyBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PATROLI,
      page: () => RiwayatPatroliView(),
      binding: RiwayatPatroliBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_LOCATION,
      page: () => SelectLocationView(),
      binding: SelectLocationBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_KEGIATAN,
      page: () => CreateKegiatanView(),
      binding: CreateKegiatanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KEGIATAN,
      page: () => DetailKegiatanView(),
      binding: DetailKegiatanBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_KEGIATAN,
      page: () => EditKegiatanView(),
      binding: EditKegiatanBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_KEJADIAN,
      page: () => EditKejadianView(),
      binding: EditKejadianBinding(),
    ),
    GetPage(
      name: _Paths.KEJADIAN,
      page: () => KejadianView(),
      binding: KejadianBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KEJADIAN,
      page: () => DetailKejadianView(),
      binding: DetailKejadianBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_KEJADIAN,
      page: () => CreateKejadianView(),
      binding: CreateKejadianBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_VITAL,
      page: () => LocationVitalView(),
      binding: LocationVitalBinding(),
    ),
    GetPage(
      name: _Paths.BEAT,
      page: () => BeatView(),
      binding: BeatBinding(),
    ),
  ];
}
