import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart'; // Import BerandaController
import 'package:urbanscholaria_app/widgets/kategori_perizinan.dart';

class SMPPerizinanView extends StatelessWidget {
  final TKPerizinanController smpPerizinanController =
      Get.put(TKPerizinanController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategory(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String title = getTitleFromCategory(snapshot.requireData);

        return PerizinanView(
          title: title,
          backgroundImage: 'assets/icons/perizinansmp.png',
          permits: smpPerizinanController.permitstk,
        );
      },
    );
  }

  Future<String> getCategory() async {
    // Mengambil kategori dari BerandaController
    BerandaController berandaController = Get.find();
    return berandaController.getSelectedCategory;
  }

  String getTitleFromCategory(String category) {
    switch (category) {
      case 'TK':
        return 'Perizinan Taman\nKanak-Kanak';
      case 'SD':
        return 'Perizinan Sekolah Dasar';
      case 'SMP':
        return 'Perizinan Sekolah\nMenengah Pertama';
      case 'SMA':
        return 'Perizinan Sekolah\nMenengah Atas';
      default:
        return 'Perizinan $category';
    }
  }
}
