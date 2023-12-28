import 'package:get/get.dart';
import 'package:urbanscholaria_app/auth/authservices.dart';

class LoginC extends GetxController {
  var isPasswordHidden = true.obs;
  var isPasswordConfirmHidden = true.obs;
  var accessToken = ''.obs;

  final AuthService _authService = Get.put(AuthService());

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
