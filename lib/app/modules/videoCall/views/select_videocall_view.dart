import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/home/controllers/home_controller.dart';
import 'package:talabang_mandau/app/modules/videoCall/controllers/select_video_call_controller.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

class  SelectVideocallView extends StatelessWidget {

  SelectVideoController controller = Get.put(SelectVideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CText("Video Call",fontSize: 16, fontWeight: FontWeight.bold,),

      ),
      body: Obx(() {
        if (controller.isListPersonilExist.isFalse) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.listPersonil.isEmpty) {
          return const Center(child: Text("Tidak ada data personil"));
        }

        return ListView.builder(
          itemCount: controller.listPersonil.length,
          itemBuilder: (context, index) {
            final p = controller.listPersonil[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    (p.nama?.isNotEmpty ?? false) ? p.nama[0].toUpperCase() : "?",
                  ),
                ),
                title: Text(p.nama ?? "-"),
                onTap: () {
                  controller.onTapCall(p.id ?? 0, p.sessionName);

                },
              ),
            );
          },
        );
      }),

    );

  }
}
