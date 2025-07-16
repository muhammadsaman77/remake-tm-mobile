import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/location_vital_controller.dart';

class LocationVitalView extends GetView<LocationVitalController> {
  LocationVitalView({super.key});
  LocationVitalController controller = Get.put(LocationVitalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          title: CText(
            "Lokasi Vital",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Container(
                  padding: EdgeInsets.only(
                    left: 24,
                  ),
                  width: 270,
                  child: DropdownButtonFormField<JenisLokasi>(
                    value: controller.jenisLokasi == null
                        ? null
                        : controller.jenisLokasi,
                    decoration: InputDecoration(
                      hintText: "Pilih Jenis Lokasi",
                      border: InputBorder.none, // Menghilangkan garis bawah
                    ),
                    items: controller.listJenisLokasi
                        .map((e) => DropdownMenuItem<JenisLokasi>(
                              value: e,
                              child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 190,
                                  child: Text(
                                    "${e.jenis}",
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.jenisLokasi = value;
                      controller.fetchDataListLokasi();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Jenis Lokasi wajib dipilih';
                      }
                      return null;
                    },
                  )),
            ),
            Obx(
              () => controller.isListLokasiExist.value
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: controller.listLokasi.length,
                        itemBuilder: (context, index) {
                          return locationCard(context, index);
                        },
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ));
  }

  Widget locationCard(BuildContext context, index) {
    return GestureDetector(
      // onTap: () => Get.to(() => DetailKegiatanView(),
      // arguments: {"dataKegiatan": controller.listKegiatan[index]}),
      child: Container(
        margin: EdgeInsets.only(top: 12, left: 24, right: 24),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.event,
                  size: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      "Nama Tempat",
                      fontSize: 12,
                      color: Color(0xFFACACAC),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 124,
                      child: CText(
                        "${controller.listLokasi[index].namaTempat ?? "-"} ",
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
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.task,
                  size: 20,
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
                      height: 4,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 124,
                      child: CText(
                        "${controller.listLokasi[index].lokasi ?? "-"} ",
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
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_pin,
                  size: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      "Koordinat",
                      fontSize: 12,
                      color: Color(0xFFACACAC),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CText(
                      fontSize: 12,
                      "${controller.listLokasi[index].lat}, ${controller.listLokasi[index].lng}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.call,
                  size: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      "No Telepon",
                      fontSize: 12,
                      color: Color(0xFFACACAC),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CText(
                      fontSize: 12,
                      "${controller.listLokasi[index].noTelp}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
