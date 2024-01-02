// auth_services.dart

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class AuthService extends GetxService {
  var accessToken = ''.obs;
  var role = ''.obs; // Tambahkan variabel peran

  Future<void> init() async {
    // Perform any initialization if needed
  }

  Future<void> login(String email, String password) async {
    try {
      var response = await GetConnect().post(
        '${BASE_API}api/login',
        {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        await saveAccessToken(response.body['access_token']);
        await saveRole(response.body['data']['role']['nama']);

        Get.snackbar(
          'Berhasil',
          'Login berhasil',
          backgroundColor: appdone500,
          colorText: appwhite,
        );

        // Tampilkan dashboard berdasarkan peran
        showDashboardBasedOnUserRole();
      } else {
        print('Failed to sign in: ${response.body}');
        Get.snackbar(
          'Gagal',
          'Email atau password salah',
          backgroundColor: appdanger500,
          colorText: appwhite,
        );
      }
    } catch (e) {
      print('Exception during sign in: $e');
      Get.snackbar('Error', 'Terjadi kesalahan saat login');
    }
  }

  Future<void> saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    accessToken.value = token;
  }

  Future<void> saveRole(String userRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', userRole);
    role.value = userRole;
  }

  String getAccessToken() {
    return accessToken.value;
  }

  String getUserRole() {
    return role.value;
  }

  void showDashboardBasedOnUserRole() {
    // Ambil peran pengguna
    String userRole = getUserRole();

    // Tentukan rute dashboard berdasarkan peran
    String dashboardRoute;

    switch (userRole) {
      case 'Operator':
        dashboardRoute = RouteNames.bottomnavigationoperator;
        break;
      case 'Verifikator':
        dashboardRoute = RouteNames.bottomnavigationverifikator;
        break;
      case 'Surveyor':
        dashboardRoute = RouteNames.bottomnavigationsurveyor;
        break;
      case 'AdminUtama':
        dashboardRoute = RouteNames.bottomnavigationadminutama;
        break;
      case 'AdminDinas':
        dashboardRoute = RouteNames.bottomnavigationadmindinas;
        break;
      default:
        // Handle unknown role
        dashboardRoute = RouteNames.bottomnavigation;
        break;
    }

    // Navigasi ke dashboard yang sesuai
    Get.offNamed(dashboardRoute);
  }
}
