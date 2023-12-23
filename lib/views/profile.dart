import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/auth/authController.dart';

import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/profile_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class ProfileView extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("PROFILE"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height:
                                            200, // Sesuaikan dengan tinggi yang diinginkan
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    controller.namaLengkapController.text,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: appwhite,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    controller.pekerjaanController.text,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: appwhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 15, left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: appbrand50,
                          borderRadius: BorderRadius.circular(
                              12), // Sesuaikan dengan radius yang diinginkan
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.person_2,
                            color: appbrand500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: appneutral800,
                          ),
                          title: Text(
                            'Data Profil',
                            style: TextStyle(
                                color: appbrand800,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          onTap: () {
                            Get.toNamed(RouteNames.editprofile);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 15, left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: appbrand50,
                          borderRadius: BorderRadius.circular(
                              12), // Sesuaikan dengan radius yang diinginkan
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.question_answer,
                            color: appbrand500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: appneutral800,
                          ),
                          title: Text(
                            'FAQs',
                            style: TextStyle(
                                color: appbrand800,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          onTap: () {
                            Get.toNamed(RouteNames.faq);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 15, left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: appbrand50,
                          borderRadius: BorderRadius.circular(
                              12), // Sesuaikan dengan radius yang diinginkan
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.data_thresholding_rounded,
                            color: appbrand500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: appneutral800,
                          ),
                          title: Text(
                            'Syarat dan Ketentuan',
                            style: TextStyle(
                                color: appbrand800,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          onTap: () {
                            Get.toNamed(RouteNames.syaratdanketentuan);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 15, left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: appbrand50,
                          borderRadius: BorderRadius.circular(
                              12), // Sesuaikan dengan radius yang diinginkan
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.info,
                            color: appbrand500,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: appneutral800,
                          ),
                          title: Text(
                            'Kontak dan Tentang',
                            style: TextStyle(
                                color: appbrand800,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          onTap: () {
                            Get.toNamed(RouteNames.about);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 15, left: 15),
                      child: GestureDetector(
                        onTap: () => _showExitConfirmationDialog(),
                        child: ButtonWidgets(
                          label: "Keluar",
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showExitConfirmationDialog() {
  AwesomeDialog(
    context: Get.overlayContext!,
    dialogType: DialogType.question,
    title: 'Konfirmasi',
    desc: 'Apakah kamu yakin ingin keluar?',
    btnCancelOnPress: () {
      Get.back();
    },
    btnOkOnPress: () async {
      await Get.find<AuthController>().logout();
    },
  )..show();
}
