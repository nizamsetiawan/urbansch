import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/views/detailriwayatperizinan.dart';
import 'package:urbanscholaria_app/widgets/null.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:open_file/open_file.dart';

class RiwayatView extends StatefulWidget {
  @override
  _RiwayatViewState createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  int? userId; // Define userId here

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserId().then((value) {
      setState(() {
        userId = value;
        print(userId);
      });
    });
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

  Widget buildCard(Map<String, dynamic>? data) {
    if (data == null) {
      return SizedBox.shrink();
    }

    final suratJenis = data['surat_jenis'] as Map<String, dynamic>?;
    Color statusColor = Colors.orange;

    if (data['status'] == 'Ditolak') {
      statusColor = Colors.red;
    } else if (data['status'] == 'Penjadwalan Survey') {
      statusColor = Colors.orange;
    } else if (data['status'] == 'Selesai') {
      statusColor = Colors.green;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              requestData: data,
              namaLengkap:
                  data['user']['nama_lengkap'] ?? 'Nama Lengkap Tidak Tersedia',
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perizinan ${data['kategori'] ?? 'Tanggal Tidak Tersedia'}',
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
                        data['created_at'] ?? DateTime.now().toString())),
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
                    '${data['nama'] ?? 'Nama Tidak Tersedia'}',
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
                    '${data['alamat_lokasi'] ?? 'Alamat Tidak Tersedia'}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'ID Pengajuan: ${data['id'] ?? 'ID Tidak Tersedia'}',
                style: TextStyle(
                  color: appbrand500,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status: ${data['status'] ?? 'Status Tidak Tersedia'}',
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      String suratId = data['id'].toString();
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
    );
  }

  Widget buildVerifikasiScreen(List<dynamic>? data) {
    if (data == null) {
      return CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildCard(data[index]);
      },
    );
  }

  Widget buildSurveyScreen(List<dynamic>? data) {
    if (data == null) {
      return CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildCard(data[index]);
      },
    );
  }

  Widget buildDitolakScreen(List<dynamic>? data) {
    if (data == null) {
      return CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildCard(data[index]);
      },
    );
  }

  Widget buildSelesaiScreen(List<dynamic>? data) {
    if (data == null) {
      return CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildCard(data[index]);
      },
    );
  }

  Future<List<dynamic>> fetchData(String queryParameters, int? userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    try {
      final response = await http.get(
        Uri.parse(
            'https://urbanscholaria.my.id/api/surat$queryParameters&user_id=$userId'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Data ali. Status code: ${responseData}');

        List<dynamic> data = responseData['data'] ?? [];
        return data;
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception('Gagal memuat data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw Exception('Error mengambil data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("RIWAYAT"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.arrow_back_ios),
                buildTab('Verifikasi', 0, Icons.verified),
                buildTab('Survey', 1, Icons.map_sharp),
                buildTab('Ditolak', 2, Icons.do_not_touch_outlined),
                buildTab('Selesai', 3, Icons.document_scanner),
                Icon(Icons.arrow_forward_ios),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  FutureBuilder(
                    future: fetchData('?status=Verifikasi Operator', userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        print("Error: ${snapshot.error}");
                        return nullvalue();
                      } else {
                        print("Data yang diterima: ${snapshot.data}");
                        return buildVerifikasiScreen(snapshot.data);
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData('?status=Penjadwalan Survey', userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return nullvalue();
                      } else {
                        return buildSurveyScreen(snapshot.data);
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData('?status=Ditolak', userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return nullvalue();
                      } else {
                        return buildDitolakScreen(snapshot.data);
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData('?status=Selesai', userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return nullvalue();
                      } else {
                        return buildSelesaiScreen(snapshot.data);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String title, int index, IconData icon) {
    return InkWell(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentIndex == index ? appbrand500 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _currentIndex == index ? appbrand500 : Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _currentIndex == index ? appbrand500 : Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
