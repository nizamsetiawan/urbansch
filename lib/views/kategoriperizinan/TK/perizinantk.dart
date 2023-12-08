import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/controllers/kategoriperizinan/TK/perizinantk_c.dart';
import 'package:urbanscholaria_app/widgets/kategori_perizinan.dart';

class TKPerizinanView extends StatelessWidget {
  final TKPerizinanController tkPerizinanController =
      Get.put(TKPerizinanController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategory(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String title = getTitleFromCategory(snapshot.requireData);

        return PerizinanView(
          title: title,
          backgroundImage: 'assets/icons/perizinantk.png',
          permits: tkPerizinanController.permitstk,
        );
      },
    );
  }

  Future<String> getCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('selected_category') ?? 'TK';
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
