import 'package:flutter/material.dart';
import 'package:talabang_mandau/app/env/colors.dart';
import 'package:talabang_mandau/app/widgets/text.dart';
class FormCard extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final double percentage;
  final bool dataWorkorderIsDone;
  final String type;

  FormCard(
      {Key? key,
      required this.text,
      required this.percentage,
      required this.dataWorkorderIsDone,
      required this.function,
      this.type = "QE GAMAS"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool enabled = !dataWorkorderIsDone &&
            text != "Data Workorder" &&
            text != "Informasi OLT"
        ? false
        : true;

    IconData icon() {
      switch (text) {
        case "Data Workorder":
          return Icons.task;
        case "Form Ruas":
          return Icons.route;
        case "Form KHS":
          return Icons.inventory_2;
        case "Impact Service":
          return Icons.map;
        case "Material Return":
          return Icons.model_training;
        case "Informasi OLT":
          return Icons.task;
        case "Suhu OLT":
          return Icons.thermostat;
        case "Baterai & Lingkungan OLT":
          return Icons.battery_charging_full;
        case "Power OLT":
          return Icons.bolt;
        case "Bir OLT":
          return Icons.router;
        default:
          return Icons.task;
      }
    }

    Widget status() {
      Color color = Color(0xFFAAAAAA);
      String statusText = "Belum Dikerjakan";

      switch (percentage) {
        case 100:
          color = green;
          statusText = "Sudah Dikerjakan";
        case < 100:
          color = Color(0xFFAAAAAA);
          statusText = "Belum Dikerjakan";
          break;
        default:
          color = Color(0xFFAAAAAA);
          statusText = "Belum Dikerjakan";
      }

      if (!enabled) {
        color = Color(0xFF656667);
        statusText = type == "GCU OLT"
            ? "Kerjakan Informasi OLT dahulu"
            : "Kerjakan Data Workorder dahulu";
      }

      return Container(
        width: MediaQuery.sizeOf(context).width,
        color: color,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: CText(
          statusText,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 12,
        ),
      );
    }

    return GestureDetector(
      onTap: enabled ? function : null,
      child: Container(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(icon()),
                  SizedBox(
                    width: 16,
                  ),
                  CText(
                    text,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  Spacer(),
                  Icon(
                    enabled ? Icons.keyboard_arrow_right : Icons.lock,
                    size: 24,
                  ),
                ],
              ),
            ),
            status()
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.1),
              offset: Offset(0, 1),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );

    // !dataWorkorderIsDone && text != "Data Workorder"
    //     ? GestureDetector(
    //         onTap: () {
    //           errorMessage("Lengkapi Data Workorder terlebih dahulu!");
    //         },
    //         child: Container(
    //           height: 72,
    //           width: MediaQuery.sizeOf(context).width,
    //           decoration: BoxDecoration(
    //             color: Colors.grey[300],
    //             borderRadius: BorderRadius.circular(14),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Color(0xFF000000).withOpacity(0.1),
    //                 offset: Offset(0, 1),
    //                 blurRadius: 15,
    //                 spreadRadius: 0,
    //               ),
    //             ],
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 percentage != 100
    //                     ? Icon(
    //                         Icons.timelapse,
    //                         size: 30,
    //                         color: passiveColor,
    //                       )
    //                     : Icon(
    //                         Icons.check_circle_outline_rounded,
    //                         size: 30,
    //                         color: green,
    //                       ),
    //                 CText(
    //                   text,
    //                   fontSize: 16,
    //                 ),
    //                 Icon(
    //                   Icons.edit_square,
    //                   size: 30,
    //                   color: Color(0xFFAAAAAA),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     : GestureDetector(
    //         onTap: function,
    //         child: Container(
    //           height: 72,
    //           width: MediaQuery.sizeOf(context).width,
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(14),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Color(0xFF000000).withOpacity(0.1),
    //                 offset: Offset(0, 1),
    //                 blurRadius: 15,
    //                 spreadRadius: 0,
    //               ),
    //             ],
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 percentage != 100
    //                     ? Icon(
    //                         Icons.timelapse,
    //                         size: 30,
    //                         color: passiveColor,
    //                       )
    //                     : Icon(
    //                         Icons.check_circle_outline_rounded,
    //                         size: 30,
    //                         color: green,
    //                       ),
    //                 CText(
    //                   text,
    //                   fontSize: 16,
    //                 ),
    //                 Icon(
    //                   Icons.edit_square,
    //                   size: 30,
    //                   color: Color(0xFFAAAAAA),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
  }
}
