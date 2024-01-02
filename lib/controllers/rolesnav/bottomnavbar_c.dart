import 'package:get/get.dart';

import 'package:urbanscholaria_app/views/operator/dashboard.dart';
import 'package:urbanscholaria_app/views/operator/feedback.dart';
import 'package:urbanscholaria_app/views/operator/perizinan.view.dart';
import 'package:urbanscholaria_app/views/operator/verifikasi.dart';
import 'package:urbanscholaria_app/views/profile.dart';
import 'package:urbanscholaria_app/views/surveyor/verifikasi.dart';
import 'package:urbanscholaria_app/views/verifikator/verifikasi.dart';

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

class VerifikatorBottomnavigationController extends GetxController {
  RxInt CurrentIndex = 0.obs;

  final screens = [
    OperatorDashboardView(),
    OperatorPerizinanView(),
    VerifikatorVerifikasiView(),
    OperatorFeedbackView(),
    ProfileView(),
  ];

  SetIndex(index) {
    print(index);
    CurrentIndex.value = index;
    update();
  }
}

class SurveyorBottomnavigationController extends GetxController {
  RxInt CurrentIndex = 0.obs;

  final screens = [
    OperatorDashboardView(),
    OperatorPerizinanView(),
    SurveyorVerifikasiView(),
    OperatorFeedbackView(),
    ProfileView(),
  ];

  SetIndex(index) {
    print(index);
    CurrentIndex.value = index;
    update();
  }
}

class AdminDinasBottomnavigationController extends GetxController {
  RxInt CurrentIndex = 0.obs;

  final screens = [
    OperatorDashboardView(),
    OperatorPerizinanView(),
    SurveyorVerifikasiView(),
    OperatorFeedbackView(),
    ProfileView(),
  ];

  SetIndex(index) {
    print(index);
    CurrentIndex.value = index;
    update();
  }
}

class AdminUtamaBottomnavigationController extends GetxController {
  RxInt CurrentIndex = 0.obs;

  final screens = [
    OperatorDashboardView(),
    OperatorPerizinanView(),
    SurveyorVerifikasiView(),
    OperatorFeedbackView(),
    ProfileView(),
  ];

  SetIndex(index) {
    print(index);
    CurrentIndex.value = index;
    update();
  }
}
