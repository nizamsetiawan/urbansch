import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/models/profile_m.dart';

class EditProfileController extends GetxController {
  var userData = {}.obs;
  var isLoading = false.obs;
  var isChecked = false.obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController nomorIdentitasController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kabupatenKotaController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();
  TextEditingController kelurahanController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    fetchUser();
  }

  Future<void> updateProfilePicture() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Handle the picked file (upload to server or process locally)
        // You may need to use another package to upload the image to your server

        // For now, you can set the local path to the image to the 'fotoController'
        fotoController.text = pickedFile.path;

        // Notify the UI to update the profile picture
        update();
      }
    } catch (error) {
      print('Error picking image: $error');
    }
  }

  Future<void> fetchUser() async {
    try {
      isLoading(true);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        return;
      }

      var url = Uri.parse(BASE_API + "api/profile");
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        print('Response Body: $jsonResponse');
        isLoading(false);
        // Mengakses user_id
        var userId = jsonResponse['data']['id'];
        print('User ID: $userId');

        // Menyimpan user_id di SharedPreferences
        prefs.setInt('user_id', userId);

        // Set nilai controller sesuai dengan data dari API
        usernameController.text = jsonResponse['data']['username'] ?? '';
        emailController.text = jsonResponse['data']['email'] ?? '';
        namaLengkapController.text = jsonResponse['data']['nama_lengkap'] ?? '';
        fotoController.text = jsonResponse['data']['foto'] ?? '';
        nomorIdentitasController.text =
            jsonResponse['data']['nomor_identitas'] ?? '';
        jenisKelaminController.text =
            jsonResponse['data']['jenis_kelamin'] ?? '';
        tempatLahirController.text = jsonResponse['data']['tempat_lahir'] ?? '';
        tanggalLahirController.text =
            jsonResponse['data']['tanggal_lahir'] ?? '';
        provinsiController.text = jsonResponse['data']['provinsi'] ?? '';
        kabupatenKotaController.text =
            jsonResponse['data']['kabupaten_kota'] ?? '';
        kecamatanController.text = jsonResponse['data']['kecamatan'] ?? '';
        kelurahanController.text = jsonResponse['data']['kelurahan'] ?? '';
        alamatController.text = jsonResponse['data']['alamat'] ?? '';
        noTelpController.text = jsonResponse['data']['no_telp'] ?? '';
        pekerjaanController.text = jsonResponse['data']['pekerjaan'] ?? '';
      } else {
        print('Failed to load profile: ${response.statusCode}');
        isLoading(false);
      }
    } catch (error) {
      print('Error: $error');
      isLoading(false);
    }
  }

  bool isValidData() {
    return true;
  }

  Future<bool> postDataToApi() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        return false;
      }

      var url = Uri.parse(BASE_API + "api/update-profile");
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'no_telp': noTelpController.text,
          'pekerjaan': pekerjaanController.text,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil',
          'Data Tersimpan',
          backgroundColor: appdone500,
          colorText: appwhite,
        );
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  void saveData() async {
    if (!isValidData()) {
      // Tampilkan pesan kesalahan atau lakukan sesuatu sesuai kebutuhan
      return;
    }

    bool success = await postDataToApi();

    if (success) {
      print('Data berhasil disimpan');
      // Setelah sukses menyimpan data, perbarui UI
      fetchUser();
    } else {
      print('Gagal menyimpan data');
    }
  }
}

class FAQController extends GetxController {
  var faqs = <FAQModel>[
    FAQModel(
      question: 'Apakah data saat mengajukan perizinan bisa diubah?',
      answer:
          'Saat perizinan sudah diajukan, data perizinan tidak dapat diubah sampai pengajuan dizinkan/ditolak.',
    ),
    FAQModel(
      question: 'Pertanyaan 2',
      answer: 'Jawaban untuk pertanyaan 2.',
    ),
    FAQModel(
      question: 'Pertanyaan 3',
      answer: 'Jawaban untuk pertanyaan 3.',
    ),
    // Tambahkan FAQModel lainnya sesuai kebutuhan
  ].obs;
}
