import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/views/pemohon/detailriwayatperizinan.dart';
import 'package:http/http.dart' as http;

class UserCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserCard({required this.userData});

  @override
  Widget build(BuildContext context) {
    // Check if the 'data' key is available
    if (userData.containsKey('data') && userData['data'] is List<dynamic>) {
      // Assume the first item in the 'data' list is the relevant data
      Map<String, dynamic> applicationData = userData['data'][0];

      final suratJenis =
          applicationData['surat_jenis'] as Map<String, dynamic>?;
      Color statusColor = Colors.orange;

      if (applicationData['status'] == 'Ditolak') {
        statusColor = Colors.red;
      } else if (applicationData['status'] == 'Penjadwalan Survey') {
        statusColor = Colors.orange;
      } else if (applicationData['status'] == 'Selesai') {
        statusColor = Colors.green;
      }

      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                requestData: applicationData,
                namaLengkap: applicationData['user']['nama_lengkap'] ??
                    'Nama Lengkap Tidak Tersedia',
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 280,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perizinan ${applicationData['kategori'] ?? 'Tanggal Tidak Tersedia'}',
                    style: TextStyle(
                      fontSize: 16,
                      color: appneutral800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    suratJenis?['nama'] ?? 'Nama Tidak Tersedia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: appneutral500,
                      ),
                      Text(
                        DateFormat('yyyy MMMM dd').format(DateTime.parse(
                            applicationData['created_at'] ??
                                DateTime.now().toString())),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.blinds_closed_outlined,
                        color: appneutral500,
                      ),
                      Text(
                        '${applicationData['nama'] ?? 'Nama Tidak Tersedia'}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.map,
                        color: appneutral500,
                      ),
                      Text(
                        '${applicationData['alamat_lokasi'] ?? 'Alamat Tidak Tersedia'}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ID Pengajuan: ${applicationData['id'] ?? 'ID Tidak Tersedia'}',
                    style: TextStyle(
                      color: appbrand500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status: ${applicationData['status'] ?? 'Status Tidak Tersedia'}',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          String suratId = applicationData['id'].toString();
                          downloadFile(suratId);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          color: appbrand100,
                          child: const Icon(
                            Icons.download,
                            color: appbrand500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Data tidak valid'),
        ),
      );
    }
  }
}

Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id');
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
