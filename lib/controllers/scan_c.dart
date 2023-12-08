import 'package:get/get.dart';

class ScanController extends GetxController {
  RxString scanResult = RxString("");

  // Future<void> scanQR() async {
  //   String? barcode = await scanner.scan();
  //   if (barcode != null) {
  //     scanResult.value = barcode;
  //     print('Hasil pemindaian QR code: $barcode');
  //   } else {
  //     print('Pemindaian QR code dibatalkan atau hasil tidak valid');
  //   }
  // }
}
