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

  Widget buildCard(Map<String, dynamic>? data) {
    if (data == null) {
      return SizedBox.shrink();
    }

    final suratJenis = data['surat_jenis'] as Map<String, dynamic>?;

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
            Text(
              DateFormat('yyyy MMMM dd').format(DateTime.parse(
                  data['created_at'] ?? DateTime.now().toString())),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${data['nama'] ?? 'Nama Tidak Tersedia'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.map),
                Text(
                  '${data['alamat_lokasi'] ?? 'Alamat Tidak Tersedia'}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              'ID Pengajuan: ${data['id'] ?? 'ID Tidak Tersedia'}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${data['status'] ?? 'Status Tidak Tersedia'}',
              style: TextStyle(
                color: data['status'] == 'Pengajuan Ditolak'
                    ? Colors.red
                    : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRiwayatScreen(List<dynamic>? data) {
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
    int userId = prefs.getInt('user_id') ?? 0;

    try {
      final response = await http.get(
        Uri.parse(
            'https://urbanscholaria.my.id/api/surat/$userId$queryParameters'),
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
                buildTab('Riwayat', 0),
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
                        return buildRiwayatScreen(snapshot.data);
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

  Widget buildTab(String title, int index) {
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
