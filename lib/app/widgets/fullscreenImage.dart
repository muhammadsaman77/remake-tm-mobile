import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabang_mandau/app/widgets/text.dart';

class FullScreenImage extends StatelessWidget {
  final String imageFile;
  final Function onDelete;

  FullScreenImage({required this.imageFile, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gambar Fullscreen'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            )
          ],
        ),
        body: Image.network(
          imageFile,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Container(
                child: Center(
              child: CText("Image Error."),
            ));
          },
        ));
  }
}
