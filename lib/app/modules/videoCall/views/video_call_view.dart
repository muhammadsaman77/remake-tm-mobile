import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talabang_mandau/app/modules/videoCall/screens/prepare_videocall.dart';
import 'package:talabang_mandau/app/modules/videoCall/widgets/participant_widget.dart';
import 'package:talabang_mandau/app/widgets/button.dart';

import '../controllers/video_call_controller.dart';

class VideoCallView extends GetView<VideoCallController> {
  VideoCallView({super.key});
  VideoCallController controller = Get.put(VideoCallController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('VideoCallView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            PrimaryButton(
                text: "VIDCALL",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrepareVideocall()),
                  );
                })
          ],
        ));
  }
}
