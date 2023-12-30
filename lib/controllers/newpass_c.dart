import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class NewpassC extends GetxController {
  var isPasswordHidden = true.obs;
  var isPasswordConfirmHidden = true.obs;

  late final passwordController = TextEditingController();
  late final confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    final apiUrl = 'https://urbanscholaria.my.id/api/reset-password';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'password': passwordController.text,
          'password_confirmation': confirmPasswordController.text,
        },
      );

      if (response.statusCode == 200) {
        print('Reset Kata Sandi berhasil');
        Get.snackbar(
          'Berhasil',
          'Kata Sandi anda berhasil diubah',
          backgroundColor: appdone500,
          colorText: appwhite,
        );
        // Navigasi ke halaman login
        Get.toNamed(RouteNames.login);
      } else {
        print('Reset Kata Sandi gagal. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error resetting password: $error');
    }
  }
}
