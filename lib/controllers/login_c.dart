import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:urbanscholaria_app/auth/authservices.dart';

class LoginC extends GetxController {
  var isPasswordHidden = true.obs;
  var isPasswordConfirmHidden = true.obs;
  var accessToken = ''.obs; // Menyimpan access token di state global

  final AuthService _authService = Get.put(AuthService());

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
