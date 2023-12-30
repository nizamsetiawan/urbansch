import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class ResetPassView extends StatelessWidget {
  const ResetPassView({Key? key}) : super(key: key);

  Future<void> sendResetLink(dynamic email) async {
    final apiUrl = 'https://urbanscholaria.my.id/api/send-otp';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        print('Link reset berhasil dikirim');
        // Navigasi ke halaman OtpView
        Get.toNamed(RouteNames.otp);
      } else {
        print(
            'Gagal mengirimkan link reset. Status code: ${response.statusCode}');
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(RouteNames.onboarding);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: appneutral600,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Reset Kata Sandi",
                style: TextStyle(
                    color: appneutral600,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: appwhite,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 221,
            width: 221,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/resetpass.png"))),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hai Scholars, Silahkan masukkan email yang kamu gunakan saat mendaftar. Link reset kata sandi akan dikirimkan melalui Email. \n\nJangan bagikan Link kamu kepada siapapun!',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: appneutral600),
                ),
                const SizedBox(height: 20),
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
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: emailController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: "Masukkan Alamat Email"),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    dynamic email = emailController.text.trim();

                    if (email.isNotEmpty) {
                      await sendResetLink(email);
                      // Menampilkan Snackbar notifikasi
                      Get.snackbar(
                        'Notifikasi',
                        'Link reset telah dikirimkan ke email. Silakan cek email Anda.',
                        backgroundColor: appdone500,
                        colorText: appwhite,
                      );
                    } else {
                      print('Email cannot be empty');
                    }
                  },
                  child: const ButtonWidgets(
                    label: 'Kirim Link Reset',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
