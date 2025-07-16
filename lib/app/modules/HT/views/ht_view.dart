import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ht_controller.dart';

class HtView extends GetView<HtController> {
  const HtView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HtView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HtView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
