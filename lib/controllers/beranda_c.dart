import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class BerandaController extends GetxController {
  RxString selectedCategory = ''.obs;

  String get getSelectedCategory => selectedCategory.value;

  void handleCategoryTap(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedCategory.value = category;

    print('Kategori Terpilih: $category');

    switch (category) {
      case 'TK':
        Get.toNamed(RouteNames.perizinantk);
        break;
      case 'SD':
        Get.toNamed(RouteNames.perizinansd);
        break;
      case 'SMP':
        Get.toNamed(RouteNames.perizinansmp);
        break;
      case 'SMA':
        Get.toNamed(RouteNames.perizinansma);
        break;
    }
  }
}
