import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class AuthController extends GetxController {
  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        return;
      }

      final response = await GetConnect().post(
        '${BASE_API}api/logout',
        {},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Hapus token dari SharedPreferences
        prefs.remove('access_token');
        // Tambahkan perintah lain di sini untuk menghapus item lain jika diperlukan

        // Pindah ke halaman onboarding setelah logout
        Get.offAllNamed(RouteNames.onboarding);
      } else {
        print("Failed to logout: ${response.statusCode}");
      }
    } catch (e) {
      print('Exception during logout: $e');
    }
  }
}
