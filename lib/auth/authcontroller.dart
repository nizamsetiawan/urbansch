import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class AuthController extends GetxController {
  // ... other authentication-related code ...

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        return; // User is not authenticated
      }

      final response = await GetConnect().post(
        '${BASE_API}api/logout',
        {},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Clear locally stored token
        prefs.remove('access_token');
        print(response.statusCode);
        // Navigate to the login screen or perform other logout-related actions
        // For example, you can use Get.offAllNamed('/login') if you are using Get package for navigation.
        Get.offAllNamed(RouteNames.login);
      } else {
        print("Failed to logout: ${response.statusCode}");
        // Handle the failure, e.g., show an error message to the user
      }
    } catch (e) {
      print('Exception during logout: $e');
      // Handle the exception, e.g., show an error message to the user
    }
  }
}
