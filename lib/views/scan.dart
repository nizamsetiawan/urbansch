import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/scan_c.dart';

class ScanView extends StatelessWidget {
  final ScanController scanController = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: Text("INFORMASI PERIZINAN"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                String barcode = await FlutterBarcodeScanner.scanBarcode(
                    '#000000', 'Cancel', true, ScanMode.QR);
                scanController.scanResult.value = barcode;
                print('Hasil pemindaian QR code: $barcode');
              },
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => Text(
              scanController.scanResult.value,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
