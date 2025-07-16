import 'package:flutter/material.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

AppBar CAppBar(context, String title) {
  return AppBar(
    title: CText(
      title,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0.0,
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
  );
}
