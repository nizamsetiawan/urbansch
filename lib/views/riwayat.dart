import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:urbanscholaria_app/constant/colors.dart';

class RiwayatView extends StatefulWidget {
  @override
  _RiwayatViewState createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildCard(Map<String, dynamic>? data) {
    if (data == null) {
      // Mengatasi kasus ketika data null
      return SizedBox.shrink(); // atau elemen UI pengganti lainnya
    }

    final suratJenis = data['surat_jenis'] as Map<String, dynamic>?;
    Color statusColor = Colors.orange; // Warna default jika status tidak sesuai
    // Tentukan warna berdasarkan status
    if (data['status'] == 'Ditolak') {
      statusColor = Colors.red;
    } else if (data['status'] == 'Penjadwalan Survey') {
      statusColor = Colors.orange;
    } else if (data['status'] == 'Selesai') {
      statusColor = Colors.green;
    }

    return Card(
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
            Text(
              'Status: ${data['status'] ?? 'Status Tidak Tersedia'}',
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProsesScreen(List<dynamic>? data) {
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

  Future<List<dynamic>> fetchData(String queryParameters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    try {
      final response = await http.get(
        Uri.parse('https://urbanscholaria.my.id/api/surat$queryParameters'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        return responseData['data'];
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (error) {
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
                buildTab('Proses', 0, Icons.access_time),
                buildTab('Verifikasi', 1, Icons.verified),
                buildTab('Survey', 2, Icons.map_sharp),
                buildTab('Ditolak', 3, Icons.do_not_touch_outlined),
                buildTab('Selesai', 4, Icons.document_scanner),
                // Tambahkan tab lain sesuai kebutuhan
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
                    future: fetchData(''),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return buildProsesScreen(snapshot.data);
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData('?status=Verifikasi Operator'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        print(snapshot.data);
                        return buildVerifikasiScreen(snapshot.data);
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData('?status=Penjadwalan Survey'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return buildSurveyScreen(snapshot.data);
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData('?status=Ditolak'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return buildDitolakScreen(snapshot.data);
                      }
                    },
                  ),
                  FutureBuilder(
                    future: fetchData('?status=Selesai'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return buildSelesaiScreen(snapshot.data);
                      }
                    },
                  ),
                  // Tambahkan FutureBuilder lainnya untuk tab tambahan
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
