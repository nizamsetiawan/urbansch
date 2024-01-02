import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/newpass_c.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class NewpassView extends StatelessWidget {
  final NewpassC newpassC = Get.put(NewpassC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appwhite,
        title: const Text(
          "Kata Sandi Baru",
          style: TextStyle(color: appneutral600, fontSize: 20),
        ),
        centerTitle: false,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
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
          const SizedBox(height: 10),
          Container(
            height: 221,
            width: 221,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/newpass.png"))),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hai Scholars, Silahkan masukkan kata sandi baru untuk akunmu. Jaga kerahasiaan password dan jangan bagikan kepada siapapun.',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: appneutral600),
                ),
                const SizedBox(height: 20),
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
                      border: Border.all(color: appneutral400)),
                  child: Obx(() => TextField(
                        controller: newpassC.passwordController,
                        autocorrect: false,
                        obscureText: newpassC.isPasswordHidden.value,
                        style:
                            const TextStyle(fontSize: 12, color: appneutral900),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 7, 16, 10),
                          hintText: "Masukkan Kata Sandi",
                          suffixIcon: IconButton(
                            icon: Icon(newpassC.isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: appneutral400,
                            onPressed: () {
                              newpassC.isPasswordHidden.value =
                                  !newpassC.isPasswordHidden.value;
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
                  height: 20,
                ),
                const Text(
                  "Konfirmasi Kata Sandi",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: Obx(() => TextField(
                        controller: newpassC.confirmPasswordController,
                        autocorrect: false,
                        obscureText: newpassC.isPasswordConfirmHidden.value,
                        style:
                            const TextStyle(fontSize: 12, color: appneutral900),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 7, 16, 10),
                          hintText: "Masukkan Kata Sandi",
                          suffixIcon: IconButton(
                            icon: Icon(newpassC.isPasswordConfirmHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: appneutral400,
                            onPressed: () {
                              newpassC.isPasswordConfirmHidden.value =
                                  !newpassC.isPasswordConfirmHidden.value;
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
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    await newpassC.resetPassword();
                    // The resetPassword method will internally use passwordController.text
                    // Perform navigation or show success message
                  },
                  child: const ButtonWidgets(
                    label: 'Ubah Kata Sandi',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
