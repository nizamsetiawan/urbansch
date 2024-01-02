import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:urbanscholaria_app/views/verifikator/verifikasi.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class PenugasanSurveyView extends StatefulWidget {
  final Map<String, dynamic> requestData;

  PenugasanSurveyView({required this.requestData});

  @override
  _PenugasanSurveyViewState createState() => _PenugasanSurveyViewState();
}

class _PenugasanSurveyViewState extends State<PenugasanSurveyView> {
  TextEditingController namaTugasController = TextEditingController();
  TextEditingController surveyorController = TextEditingController();
  TextEditingController deskripsiTugasController = TextEditingController();
  TextEditingController tanggalPenugasanController = TextEditingController();
  TextEditingController tanggalTenggatController = TextEditingController();

  String? filePath; // Variable untuk menyimpan jalur file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("Penugasan Survey"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              " Nama Tugas",
              style: TextStyle(
                  fontSize: 14,
                  color: appneutral800,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: appneutral400),
              ),
              child: TextField(
                controller: namaTugasController,
                enabled: true,
                style: TextStyle(fontSize: 12, color: appneutral900),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                  hintText: "Beri nama tugas survey...",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Surveyor",
              style: TextStyle(
                  fontSize: 14,
                  color: appneutral800,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: appneutral400),
              ),
              child: TextField(
                controller: surveyorController,
                enabled: true,
                style: TextStyle(fontSize: 12, color: appneutral900),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                  hintText: "Tambahkan Surveyor",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Deskripsi Tugas",
              style: TextStyle(
                  fontSize: 14,
                  color: appneutral800,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: appneutral400),
              ),
              child: TextField(
                controller: deskripsiTugasController,
                enabled: true,
                style: TextStyle(fontSize: 12, color: appneutral900),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                  hintText: "Jelaskan detail tugas",
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tanggal Penugasan
            Text(
              "Tanggal Penugasan",
              style: TextStyle(
                  fontSize: 14,
                  color: appneutral800,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: appneutral400),
              ),
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1));

                  if (pickedDate != null) {
                    tanggalPenugasanController.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: tanggalPenugasanController,
                    style: TextStyle(
                        fontSize: 12,
                        color: appneutral900), // Atur font di sini
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                      hintText: "Tanggal Penugasan",
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Tanggal Tenggat",
              style: TextStyle(
                  fontSize: 14,
                  color: appneutral800,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: appneutral400),
              ),
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );

                  if (pickedDate != null) {
                    tanggalTenggatController.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: tanggalTenggatController,
                    style: TextStyle(
                        fontSize: 12,
                        color: appneutral900), // Atur font di sini
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                      hintText: "Tanggal Tenggat",
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Upload Surat Tugas",
              style: TextStyle(
                fontSize: 14,
                color: appneutral800,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: appneutral400),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _pickFile();
                    },
                    child: Text("Pilih Surat Tugas"),
                    style: ElevatedButton.styleFrom(
                      primary: appbrand500, // Warna tombol
                    ),
                  ),
                  SizedBox(width: 10), // Jarak antara button dan nama file
                  Expanded(
                    child: Text(
                      '${filePath != null ? getFileNameFromPath(filePath!) : "Belum dipilih"}',
                      style: TextStyle(
                        fontSize: 12,
                        color: appneutral800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                // Validasi input pengguna sebelum mengirim Penugasan
                if (validateInput()) {
                  int suratId = widget.requestData['id'] as int;

                  // Panggil metode untuk mengirim Penugasan
                  bool success = await sendPenugasan(suratId);

                  if (success) {
                    // Tampilkan pesan sukses atau navigasi ke layar berikutnya
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Penugasan berhasil dikirim.'),
                        backgroundColor: appdone500,
                      ),
                    );

                    // Navigasi ke layar berikutnya atau lakukan tindakan lain
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifikatorVerifikasiView()));
                  } else {
                    // Tangani kasus gagal mengirim Penugasan
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Gagal mengirim penugasan. Silakan coba lagi.'),
                        backgroundColor: appdanger500,
                      ),
                    );
                  }
                }
              },
              child: ButtonWidgets(
                label: "Kirim Penugasan",
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Metode untuk pemilihan file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.single.path!);

      setState(() {
        filePath = file.path;
        // Simpan nama file
        String fileName = result.files.single.name;
        // Tampilkan nama file di antarmuka pengguna atau lakukan yang lain sesuai kebutuhan
        print('Nama File: $fileName');
      });
    } else {}
  }

// Helper method untuk mendapatkan nama file dari jalur file
  String getFileNameFromPath(String filePath) {
    List<String> pathComponents = filePath.split('/');
    return pathComponents.last;
  }

  // Helper method untuk memvalidasi input pengguna
  bool validateInput() {
    if (namaTugasController.text.isEmpty ||
        surveyorController.text.isEmpty ||
        deskripsiTugasController.text.isEmpty ||
        tanggalPenugasanController.text.isEmpty ||
        tanggalTenggatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon isi semua kolom dengan benar.'),
          backgroundColor: appdanger500,
        ),
      );
      return false;
    }

    if (filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon pilih file surat tugas.'),
          backgroundColor: appdanger500,
        ),
      );
      return false;
    }

    return true;
  }

  // Helper method untuk mengirim Penugasan ke API
  Future<bool> sendPenugasan(int suratId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    final apiUrl = '${BASE_API}api/surat/$suratId/set-jadwal-survey';

    try {
      // Gunakan metode format tanggal dari paket intl
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

      // Membuat request multipart
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        })
        ..fields.addAll({
          'user_id': suratId.toString(),
          'nama_survey': namaTugasController.text,
          'deskripsi_survey': deskripsiTugasController.text,
          'jadwal_survey': dateFormat.format(DateTime.now()),
          'tenggat_survey': '2023-09-22',
        })
        ..files.add(await http.MultipartFile.fromPath(
          'dokumen_surat_tugas',
          filePath!,
          filename: getFileNameFromPath(filePath!),
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        // Tangani keberhasilan
        print('Penugasan berhasil dikirim');
        // Opsional, Anda dapat menangani respons dari server
        final Map<String, dynamic> responseData =
            jsonDecode(await response.stream.bytesToString());
        print('Response Data: $responseData');
        return true;
      } else {
        // Tangani kesalahan
        print('Gagal mengirim Penugasan. Kode status: ${response.statusCode}');
        // Opsional, Anda dapat menangani respons error dari server
        print('Error Response: ${await response.stream.bytesToString()}');
        return false;
      }
    } catch (error) {
      // Tangani eksepsi
      print('Error mengirim Penugasan: $error');
      return false;
    }
  }
}
