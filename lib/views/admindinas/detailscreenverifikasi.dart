import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/views/verifikator/penugasansurvey.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class DetailVerifikasiAdminDInasView extends StatelessWidget {
  final Map<String, dynamic> requestData;
  final String namaLengkap;

  DetailVerifikasiAdminDInasView(
      {required this.requestData, required this.namaLengkap});

  // Updated method with explicit cast
  List<Map<String, dynamic>> getDocumentsList() {
    // Explicitly cast the list to the desired type
    return (requestData['surat_dokumen'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
  }

  Future<AwesomeDialog> _showVerificationConfirmationDialog(
      BuildContext context, int suratId) async {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      title: 'Konfirmasi Verifikasi',
      desc: 'Anda yakin ingin meneruskan pengajuan ke verifikator?',
      btnCancelText: 'Batal',
      btnCancelOnPress: () {},
      btnOkText: 'Ya',
      btnOkOnPress: () async {
        // Call the method to proceed to the verifier
        BuatTugasSurvey(suratId);

        // Show Snackbar upon success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Pengajuan permohonan telah diteruskan ke Kepala Dinas.'),
            backgroundColor: appdone500,
          ),
        );

        // Navigate back to the penjadwalan survey
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PenugasanSurveyView(requestData: requestData),
          ),
        );
      },
    )..show();
  }

  Future<AwesomeDialog> _showRejectionConfirmationDialog(
      BuildContext context, int suratId) async {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      title: 'Konfirmasi Penolakan',
      desc: 'Anda yakin ingin menolak pengajuan ini?',
      btnCancelText: 'Batal',
      btnCancelOnPress: () {},
      btnOkText: 'Ya',
      btnOkOnPress: () async {
        // Call the method to proceed to the verifier
        tolakPengajuanPermohonan(suratId);

        // Show Snackbar upon success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pengajuan permohonan telah ditolak.'),
            backgroundColor: appdanger500,
          ),
        );

        // Navigate back to the detail screen
        Navigator.of(context).pop();
      },
    )..show();
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
        title: const Text("KELENGKAPAN"),
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
                int suratId = requestData['id'] as int;

                // Show the rejection confirmation dialog
                _showRejectionConfirmationDialog(context, suratId);
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
                    'Tolak Pengajuan Permohonan',
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
                int suratId = requestData['id'] as int;

                // Call the appropriate method based on user's action
                _showVerificationConfirmationDialog(context, suratId);
              },
              child: ButtonWidgets(
                label: 'Buat Tugas Survey',
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
                // Call the method to view the document
                _viewDocument(dokumen['dokumen_upload']);
              },
              trailing: TextButton(
                onPressed: () {
                  // Call the method to view the document
                  _viewDocument(dokumen['dokumen_upload']);
                },
                child: Text(
                  'Lihat',
                  style: TextStyle(
                    color: appbrand500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(height: 1, thickness: 1), // Divider between list items
          ],
        );
      }),
    );
  }

  void _viewDocument(String documentUrl) async {
    // You can use the open_file package to open the document
    try {
      print('Opening document: $documentUrl');
      await OpenFile.open(documentUrl);
      print('Document opened successfully');
    } catch (error) {
      print('Error opening document: $error');
      // Handle the error as needed
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

  void tolakPengajuanPermohonan(int suratId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    final apiUrl = '${BASE_API}api/surat/$suratId/tolak-verifikator-baru';

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          // Add any additional data needed for rejection
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Request rejected successfully');
        // Optionally, you can handle the response from the server
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        // Add any further actions or UI updates after rejection
      } else {
        // Handle error
        print('Failed to reject request. Status code: ${response.statusCode}');
        // Optionally, you can handle the error response from the server
        print('Error Response: ${response.body}');
        // Add any error handling or UI updates in case of failure
      }
    } catch (error) {
      // Handle exceptions
      print('Error rejecting request: $error');
      // Add any exception handling or UI updates in case of an error
    }
  }

  void BuatTugasSurvey(int suratId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    final apiUrl = '${BASE_API}api/surat/$suratId/terima-verifikator';

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          // Add any additional data needed for approval
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Request approved successfully');
        // Optionally, you can handle the response from the server
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        // Add any further actions or UI updates after approval
      } else {
        // Handle error
        print('Failed to approve request. Status code: ${response.statusCode}');
        // Optionally, you can handle the error response from the server
        print('Error Response: ${response.body}');
        // Add any error handling or UI updates in case of failure
      }
    } catch (error) {
      // Handle exceptions
      print('Error approving request: $error');
      // Add any exception handling or UI updates in case of an error
    }
  }
}
