import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/modules/createKejadian/views/create_kejadian_view.dart';
import 'package:talabang_mandau/app/modules/detailKejadian/views/detail_kejadian_view.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

import '../controllers/kejadian_controller.dart';

class KejadianView extends GetView<KejadianController> {
  KejadianView({super.key});
  KejadianController controller = Get.put(KejadianController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: CText(
          "Laporan Kejadian",
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
              width: 200,
              child: DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                value: controller.typeFilter.value.isEmpty
                    ? null
                    : controller.typeFilter.value,
                decoration: InputDecoration(
                  border: InputBorder.none, // Menghilangkan garis bawah
                ),
                items: controller.listTypeFilter
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.typeFilter.value = value ?? 'BELUM DITANGANI';
                  controller.fetchDataListKejadian();
                },
              ),
            ),
          ),
          Obx(
            () => controller.typeFilter.value == "SELESAI"
                ? Container(
                    height: 48,
                    width: MediaQuery.sizeOf(context).width,
                    margin: EdgeInsets.only(left: 24, right: 24, bottom: 12),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        durationCard(3),
                        durationCard(7),
                        durationCard(14),
                        durationCard(30),
                      ],
                    ),
                  )
                : SizedBox(),
          ),
          Obx(
            () => controller.isListKejadianExist.value
                ? Expanded(
                    child: ListView.builder(
                      itemCount: controller.listKejadian.length,
                      itemBuilder: (context, index) {
                        return activityCard(context, index);
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.to(() => CreateKejadianView());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ), // Ikon di FAB
        tooltip: 'Add Item', // Tooltip ketika FAB disentuh
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget activityCard(BuildContext context, index) {
    return GestureDetector(
      onTap: () => Get.to(() => DetailKejadianView(),
          arguments: {"dataKejadian": controller.listKejadian[index]}),
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
                      "Kejadian",
                      fontSize: 12,
                      color: Color(0xFFACACAC),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    CText(
                      "${controller.listKejadian[index].kejadian}",
                      fontSize: 14,
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
                      "keterangan",
                      fontSize: 12,
                      color: Color(0xFFACACAC),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 124,
                      child: CText(
                        "${controller.listKejadian[index].keterangan ?? "-"} ",
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
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                CText(
                  fontSize: 12,
                  "${controller.convertTime(controller.listKejadian[index].waktuKejadian)}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget durationCard(int duration) {
    int value = controller.typeDuration.value;

    return GestureDetector(
      onTap: () {
        print("controller.typeDuration.value:${controller.typeDuration.value}");
        controller.typeDuration.value = duration;
        print("controller.typeDuration.value:${controller.typeDuration.value}");
        controller.fetchDataListKejadian();
      },
      child: Container(
        decoration: BoxDecoration(
            color: value == duration ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: CText("$duration Hari",
              fontSize: 14,
              color: value == duration ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
