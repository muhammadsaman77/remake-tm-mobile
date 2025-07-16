import 'package:flutter/material.dart';

AppBar CLAppBar(context, String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ),
    leading: SizedBox(
      child: Image(
        image: AssetImage("assets/images/logo_dalapa.png"),
        fit: BoxFit.cover,
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
  );
}
