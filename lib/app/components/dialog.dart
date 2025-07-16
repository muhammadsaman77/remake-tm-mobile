import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabang_mandau/app/widgets/button.dart';
import 'package:talabang_mandau/app/widgets/dialog.dart';

void confirmMessage(context, title, description, VoidCallback action) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleBoxDialog(
        title: title,
        subtitle: description,
        buttonText: 'Konfirmasi',
        secondaryButtonText: 'Batal',
        onTapSecondary: () {
          Get.back();
        },
        onTapPrimary: action,
      );
    },
  );
}

void errorMessage([String label = 'Terjadi Kesalahan', String message = '']) {
  Get.dialog(SimpleBoxDialog(
    title: label,
    subtitle: message.toString(),
    buttonText: 'Tutup',
    onTapPrimary: () {
      Get.back();
    },
  ));
}

void updateAppDialog(message, VoidCallback action) {
  Get.dialog(SimpleBoxDialog(
      title: 'Perbarui Aplikasi',
      subtitle: message.toString(),
      buttonText: 'Perbarui',
      onTapPrimary: action));
}

void popupNewsDialog(message, VoidCallback action) {
  Get.dialog(SimpleBoxDialog(
      title: 'Perbarui Aplikasi',
      subtitle: message.toString(),
      buttonText: 'Perbarui',
      onTapPrimary: action));
}

void successMessage(context, message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleBoxDialog(
        title: 'Berhasil',
        subtitle: message.toString(),
        buttonText: 'Tutup',
        onTapPrimary: () {
          Get.back();
        },
      );
    },
  );
}

void helpMessage(context, message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Informasi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff222222),
                  ),
                ),
                SizedBox(height: 10),
                dialogBody(context, "1",
                    'Anda akan melihat beberapa card yang tersedia. Klik card bertuliskan "Data Workorder".'),
                dialogBody(context, "2",
                    'Di dalam card tersebut, perhatikan indicator yang menunjukkan apakah Data Workorder sudah diisi atau belum. Jika belum, Anda akan diarahkan ke form pengisian Data Workorder.'),
                dialogBody(context, "3",
                    'Isilah semua form yang disediakan dengan informasi yang relevan dan diperlukan.'),
                dialogBody(context, "4",
                    'Setelah semua form terisi, klik tombol simpan di bagian bawah untuk menyimpan Data Workorder.'),
                dialogBody(context, "5",
                    'Jika penyimpanan berhasil, indicator pada Data Workorder akan berubah menjadi tanda centang yang menandakan bahwa Data Workorder telah terisi semua.'),
                dialogBody(context, "6",
                    'Selanjutnya, Anda dapat mengisi Ruas Gamas, Form KHS, dan Impact Service. Untuk cara pengisiannya sama seperti mengisi Data Workorder.'),
                dialogBody(context, "7",
                    'Anda diwajibkan untuk mengisi semua card dan memastikan bahwa setiap card memiliki tanda centang.'),
                dialogBody(context, "8",
                    'Terakhir, klik tombol Kirim yang terletak pada bagian paling bawah untuk mengubah status Workorder menjadi COMPLETED.'),
                dialogBody(context, "9",
                    'Dengan demikian, pengisian data Workorder Gamas Recovery telah selesai. Sekarang, Workorder menunggu konfirmasi dari Team Leader.'),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: PrimaryButton(
                          text: 'Tutup',
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget dialogBody(context, number, message) {
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. ',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xff222222),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 100,
          child: Text(
            message,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xff222222),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    ),
    SizedBox(height: 10),
  ]);
}
