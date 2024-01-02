import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> requestData;
  final String namaLengkap;

  DetailScreen({required this.requestData, required this.namaLengkap});

  // Updated method with explicit cast
  List<Map<String, dynamic>> getDocumentsList() {
    // Explicitly cast the list to the desired type
    return (requestData['surat_dokumen'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    // Use the updated method to get the list of documents
    List<Map<String, dynamic>> dokumenList = getDocumentsList();
    Color statusColor = Colors.orange;

    if (requestData['status'] == 'Ditolak') {
      statusColor = Colors.red;
    } else if (requestData['status'] == 'Penjadwalan Survey') {
      statusColor = Colors.orange;
    } else if (requestData['status'] == 'Selesai') {
      statusColor = Colors.green;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("RINCIAN PERIZINAN"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengajuan Perizinan ${requestData['kategori']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            buildDetailItem('ID Pengajuan', requestData['id'].toString()),
            buildDetailItem("Status", ""),
            Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${requestData['status'] ?? 'Status Tidak Tersedia'}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: appneutral200,
              thickness: 3,
            ),
            buildDetailItem(
              'Tanggal Pengajuan',
              DateFormat('dd MMMM yyyy').format(
                DateTime.parse(
                  requestData['created_at'] ?? DateTime.now().toString(),
                ),
              ),
            ),
            buildDetailItem(
              'Nama',
              requestData['nama'] ?? 'Nama Sekolah Tidak Tersedia',
            ),
            buildDetailItem(
              'Pemohon',
              namaLengkap,
            ),
            Divider(
              color: appneutral200,
              thickness: 3,
            ),
            buildDetailItem(
              'Alamat Sekolah',
              requestData['alamat_lokasi'] ?? 'Alamat Sekolah Tidak Tersedia',
            ),
            Divider(
              color: appneutral200,
              thickness: 3,
            ),
            buildDetailItem(
              'Latitude',
              requestData['latitude'] ?? 'Latitude Tidak Tersedia',
            ),
            buildDetailItem('Longitude', requestData['longitude']),
            Divider(
              color: appneutral200,
              thickness: 3,
            ),
            // Menampilkan daftar dokumen
            buildDetailItem(
              "Dokumen Pengajuan Perizinan",
              Text(
                '${dokumenList.length}/${dokumenList.length}', // Display the count of documents
                style: TextStyle(
                    fontSize: 12,
                    color: appbrand500,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: appbrand100, // Set purple color for the background
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.folder,
                    color: appneutral500,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Berkas Persyaratan',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: appbrand500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8), // Add some spacing after the container
            buildDokumenList(dokumenList),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _showFeedbackBottomSheet(context);
              },
              child: Container(
                width: double.infinity,
                height: 47,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: appneutral100, // Set purple color for the background
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Feedback',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: appneutral900,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                String suratId = requestData['id'].toString();

                downloadFile(suratId);
              },
              child: ButtonWidgets(
                label: 'Bukti Pengajuan Permohonan',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$label:',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: appneutral800),
              ),
            ),
            SizedBox(width: 8),
            value is String
                ? Text(
                    value,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  )
                : value, // Use the provided widget directly
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildDokumenList(List<Map<String, dynamic>> dokumenList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(dokumenList.length, (index) {
        final dokumen = dokumenList[index];
        final namaDokumen =
            dokumen['surat_syarat']['nama'] ?? 'Nama Dokumen Tidak Tersedia';
        final linkDokumen = dokumen['dokumen_upload']?.split('/').last ??
            'Nama Dokumen Tidak Tersedia';

        return Column(
          children: [
            ListTile(
              title: Text(namaDokumen),
              subtitle: Text(linkDokumen),
              onTap: () {
                // Tambahkan logika untuk menampilkan dokumen atau navigasi ke layar lain
                // Anda mungkin ingin menggunakan plugin webview atau membuka URL eksternal.
              },
            ),
            Divider(height: 1, thickness: 1), // Divider between list items
          ],
        );
      }),
    );
  }

  void _showFeedbackBottomSheet(BuildContext context) {
    TextEditingController feedbackController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beri tahu kami feedbackmu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Ceritakan saran dan feedbackmu disini',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Isi Feedback',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  String feedback = feedbackController.text;
                  if (feedback.isNotEmpty) {
                    bool success =
                        await postFeedbackToApi(requestData['id'], feedback);
                    Navigator.pop(context); // Close the bottom sheet

                    if (success) {
                      _showFeedbackSentDialog(context);
                    }
                  }
                },
                child: ButtonWidgets(
                  label: "Kirim Feedback",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFeedbackSentDialog(BuildContext context) {
    Get.snackbar(
      'Berhasil',
      'Feedback Anda berhasil terkirim.',
      backgroundColor: appdone500,
      colorText: appwhite,
      snackPosition: SnackPosition.TOP,
    );
  }

  Future<bool> postFeedbackToApi(int suratId, String isi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    final apiUrl = '${BASE_API}api/feedback-pemohon';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'surat_id': suratId,
          'isi': isi,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Feedback posted successfully');
        // Optionally, you can handle the response from the server
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        return true; // Return true to indicate success
      } else {
        // Handle error
        print('Failed to post feedback. Status code: ${response.statusCode}');
        // Optionally, you can handle the error response from the server
        print('Error Response: ${response.body}');
        return false; // Return false to indicate failure
      }
    } catch (error) {
      // Handle exceptions
      print('Error posting feedback: $error');
      return false; // Return false to indicate failure
    }
  }

  void downloadFile(String suratId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    try {
      final response = await http.get(
        Uri.parse(
            'https://urbanscholaria.my.id/api/surat/$suratId/cetak-kwitansi'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final List<int> responseData = response.bodyBytes;

        // Save the PDF to a temporary file.
        final tempDir = await getTemporaryDirectory();
        final tempPath = tempDir.path;
        final filePath = '$tempPath/example.pdf';
        await File(filePath).writeAsBytes(responseData);

        // Open the PDF using the 'open_file' package.
        OpenFile.open(filePath);
      } else {
        throw 'Failed to download file. Status code: ${response.statusCode}';
      }
    } catch (error) {
      print('Error downloading file: $error');
      // Handle the error as needed
    }
  }
}
