import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/button.dart';
import 'package:http/http.dart' as http;

class OtpView extends StatelessWidget {
  OtpView({Key? key}) : super(key: key);

  // Deklarasikan variabel otp di sini
  String otp = '';

  Future<void> verifyOtp(String otp) async {
    final apiUrl = 'https://urbanscholaria.my.id/api/verify-otp';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'otp': otp},
      );

      if (response.statusCode == 200) {
        print('Verifikasi Kode berhasil');
        Get.toNamed(RouteNames.newpass);
        // Tambahkan navigasi atau logika sesuai kebutuhan setelah verifikasi berhasil
      } else {
        print('Verifikasi Kode gagal. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error verifikasi kode: $error');
    }
  }

  Future<void> sendOtpAgain() async {
    final apiUrl = 'https://urbanscholaria.my.id/api/send-otp-again';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Permintaan kirim ulang kode OTP berhasil');
        Get.snackbar(
          "Informasi",
          "Kode OTP baru telah dikirimkan",
          backgroundColor: appdone500,
          colorText: appwhite,
        );
        // Tambahkan logika atau tindakan setelah berhasil mengirim ulang kode OTP
      } else {
        print(
            'Gagal mengirim ulang kode OTP. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error mengirim ulang kode OTP: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appwhite,
        title: const Text(
          "Verifikasi Kode OTP",
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
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10),
          Container(
            height: 221,
            width: 221,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/otp.png"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hai Scholars, Silahkan masukkan kode OTP yang telah kami kirimkan melalui email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: appneutral600,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 200,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // Simpan nilai OTP setiap kali berubah
                      otp = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukkan Kode OTP',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Panggil fungsi untuk melakukan verifikasi OTP
                  verifyOtp(otp);
                },
                child: ButtonWidgets(
                  label: "Verifikasi Kode",
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tidak menerima kode? ',
                    style: TextStyle(
                      fontSize: 14,
                      color: appneutral600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Panggil fungsi untuk mengirim ulang kode OTP
                      sendOtpAgain();
                    },
                    child: Text(
                      'Kirim ulang kode OTP',
                      style: TextStyle(
                        fontSize: 14,
                        color: appbrand500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
