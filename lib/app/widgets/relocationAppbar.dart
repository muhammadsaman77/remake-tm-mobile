import 'package:flutter/material.dart';
import 'package:talabang_mandau/app/env/colors.dart';

AppBar relocationAppBar(controller) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      "Relokasi",
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ),
    centerTitle: true,
    actions: [
      const Card(
          color: Colors.white,
          elevation: 0.0,
          child: SizedBox(
            child: Image(
              image: AssetImage("assets/images/logo_dalapa.png"),
              fit: BoxFit.cover,
            ),
          ))
    ],
    bottom: TabBar(
      controller: controller.tabController,
      tabs: [
        Tab(text: 'LISTING'),
        Tab(text: 'PROGRESS'),
        Tab(text: 'COMPLETE'),
        Tab(text: 'REVISI'),
      ],
      labelStyle: TextStyle(color: Colors.black),
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: primaryColor, width: 2.0),
      ),
    ),
  );
}
