import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/login_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class LoginView extends StatelessWidget {
  final LoginC controller = Get.put(LoginC());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appwhite,
        title: const Text(
          "Masuk",
          style: TextStyle(color: appneutral600, fontSize: 20),
        ),
        centerTitle: false,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.offAllNamed(RouteNames.onboarding);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: appneutral600,
            size: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Segera Kembali ke US!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 221,
            width: 221,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/daftar.png"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: appneutral400),
                  ),
                  child: TextField(
                    controller: emailController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                      hintText: "Masukkan Alamat Email",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Kata Sandi",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: appneutral400),
                  ),
                  child: Obx(() => TextField(
                        controller: passwordController,
                        autocorrect: false,
                        obscureText: controller.isPasswordHidden.value,
                        style:
                            const TextStyle(fontSize: 12, color: appneutral900),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 7, 16, 10),
                          hintText: "Masukkan Kata Sandi",
                          suffixIcon: IconButton(
                            icon: Icon(controller.isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: appneutral400,
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RouteNames.resetpass);
                      },
                      child: const Text(
                        "Lupa Kata Sandi?",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    if (email.isNotEmpty && password.isNotEmpty) {
                      controller.login(email, password);
                    } else {
                      if (email.isEmpty && password.isEmpty) {
                        // Jika keduanya kosong
                        Get.snackbar(
                          'Peringatan',
                          'Isi email dan kata sandi terlebih dahulu',
                          backgroundColor: appdanger500,
                          colorText: appwhite,
                        );
                      } else if (email.isEmpty) {
                        // Jika email kosong
                        Get.snackbar(
                          'Peringatan',
                          'Isi email terlebih dahulu',
                          backgroundColor: appdanger500,
                          colorText: appwhite,
                        );
                      } else {
                        // Jika password kosong
                        Get.snackbar(
                          'Peringatan',
                          'Isi kata sandi terlebih dahulu',
                          backgroundColor: appdanger500,
                          colorText: appwhite,
                        );
                      }
                    }
                  },
                  child: ButtonWidgets(label: 'Masuk'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun?",
                      style: TextStyle(
                        color: appneutral600,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RouteNames.daftar);
                      },
                      child: const Text(
                        "Daftar Sekarang",
                        style: TextStyle(
                            color: appbrand500,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
