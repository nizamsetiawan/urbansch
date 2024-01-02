import 'package:get/get.dart';
import 'package:urbanscholaria_app/views/pemohon/beranda.dart';
import 'package:urbanscholaria_app/views/chat.dart';
import 'package:urbanscholaria_app/views/profile.dart';
import 'package:urbanscholaria_app/views/pemohon/riwayat.dart';
import 'package:urbanscholaria_app/views/scan.dart';

class BottomnavigationController extends GetxController {
  RxInt CurrentIndex = 0.obs;

  final screens = [
    BerandaView(),
    RiwayatView(),
    ScanView(),
    ChatView(),
    ProfileView(),
  ];

  SetIndex(index) {
    print(index);
    CurrentIndex.value = index;
    update();
  }
}
