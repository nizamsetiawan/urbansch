import 'package:get/get.dart';
import 'package:urbanscholaria_app/views/beranda.dart';
import 'package:urbanscholaria_app/views/chat.dart';
import 'package:urbanscholaria_app/views/operator/dashboard.dart';
import 'package:urbanscholaria_app/views/operator/feedback.dart';
import 'package:urbanscholaria_app/views/operator/perizinan.view.dart';
import 'package:urbanscholaria_app/views/operator/verifikasi.dart';
import 'package:urbanscholaria_app/views/profile.dart';
import 'package:urbanscholaria_app/views/riwayat.dart';
import 'package:urbanscholaria_app/views/scan.dart';

class OperatorBottomnavigationController extends GetxController {
  RxInt CurrentIndex = 0.obs;

  final screens = [
    OperatorDashboardView(),
    OperatorPerizinanView(),
    OperatorVerifikasiView(),
    OperatorFeedbackView(),
    ProfileView(),
  ];

  SetIndex(index) {
    print(index);
    CurrentIndex.value = index;
    update();
  }
}
