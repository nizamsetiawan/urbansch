import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class DaftarC extends GetxController {
  var isPasswordHidden = true.obs;
  var isPasswordConfirmHidden = true.obs;
  var jenis_kelamin = 'Laki-Laki'.obs;
  var jenis_identitas = 'KTP'.obs;

  void setjenis_kelamin(String value) {
    jenis_kelamin.value = value;
  }

  void setJenis_identitas(String value) {
    jenis_identitas.value = value;
  }

  void selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != dateController.text) {
      dateController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  Future<void> daftar(
    dynamic email,
    dynamic username,
    dynamic password,
    dynamic nama_lengkap,
    dynamic foto,
    dynamic ktp,
    dynamic jenis_identitas,
    dynamic nomor_identitas,
    dynamic jenis_kelamin,
    dynamic tempat_lahir,
    dynamic tanggal_lahir,
    dynamic provinsi,
    dynamic kabupaten_kota,
    dynamic kecamatan,
    dynamic kelurahan,
    dynamic alamat,
    dynamic no_telp,
    dynamic pekerjaan,
  ) async {
    try {
      var formData = http.MultipartRequest(
        'POST',
        Uri.parse('https://urbanscholaria.my.id/api/register'),
      )
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['nama_lengkap'] = nama_lengkap
        ..fields['jenis_identitas'] = jenis_identitas
        ..fields['nomor_identitas'] = nomor_identitas
        ..fields['jenis_kelamin'] = jenis_kelamin
        ..fields['tempat_lahir'] = tempat_lahir
        ..fields['tanggal_lahir'] = tanggal_lahir
        ..fields['provinsi'] = provinsi
        ..fields['kabupaten_kota'] = kabupaten_kota
        ..fields['kecamatan'] = kecamatan
        ..fields['kelurahan'] = kelurahan
        ..fields['alamat'] = alamat
        ..fields['no_telp'] = no_telp
        ..fields['pekerjaan'] = pekerjaan
        ..files.add(await http.MultipartFile.fromPath('foto', foto))
        ..files.add(await http.MultipartFile.fromPath('ktp', ktp));

      await sendFormDataToServer(formData);
    } catch (e) {
      print('Exception during sign in: $e');
    }
  }

  Future<void> sendFormDataToServer(http.MultipartRequest request) async {
    try {
      // Kirim POST request dengan formData
      http.StreamedResponse streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        // Tanggapi jika berhasil

        var jsonResponse = await streamedResponse.stream.bytesToString();
        print(jsonResponse);

        Get.snackbar(
          'Berhasil',
          'Akun anda berhasil dibuat',
          backgroundColor: appdone500,
          colorText: appwhite,
        );
        Get.offNamed(RouteNames.login);
      } else {
        // Tanggapi jika gagal
        print('Failed to sign in: ${streamedResponse.statusCode}');
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi
      print('Error: $error');
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}
