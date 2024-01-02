import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/profile_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class AdminUtamaDashboardView extends StatelessWidget {
  final BerandaController controller = Get.put(BerandaController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  final TextEditingController searchController = TextEditingController();

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
        print('API Response Data: $responseData');

        List<dynamic> data = responseData['data'] ?? [];

        // Sort data based on status
        data.sort((a, b) {
          return a['status'].compareTo(b['status']);
        });

        return data;
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw Exception('Error fetching data: $error');
    }
  }

  Widget _buildStatusView({
    required String title,
    required String statusFilter,
  }) {
    Color statusColor = Colors.black; // Default color

    // Set color based on status
    if (statusFilter == '') {
      statusColor = Colors.yellow; // Yellow for 'Pengajuan Masuk'
    } else if (statusFilter == 'Selesai') {
      statusColor = Colors.green; // Green for 'Pengajuan Diterima'
    } else if (statusFilter == 'Ditolak') {
      statusColor = Colors.red; // Red for 'Pengajuan Ditolak'
    } else if (statusFilter == 'Penjadwalan Survey') {
      statusColor = Colors.blue; // Blue for 'Proses Survey'
    }

    return FutureBuilder(
      future: fetchData('?status=$statusFilter'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return _buildErrorView();
        } else {
          List<dynamic> data = snapshot.data ?? [];
          int totalCount = data.length;

          return Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '$totalCount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: statusColor, // Set color based on status
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildErrorView() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Error',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.red, // Change color as needed
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Failed to fetch data.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriPerizinanView() {
    return FutureBuilder(
      future: fetchData(''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return _buildErrorView();
        } else {
          List<dynamic> data = snapshot.data ?? [];

          // Group data by 'kategori'
          Map<String, List<dynamic>> groupedData = {};
          for (var item in data) {
            String kategori = item['kategori'] as String;
            if (!groupedData.containsKey(kategori)) {
              groupedData[kategori] = [];
            }
            groupedData[kategori]!.add(item);
          }

          return Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kategori Perizinan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                // Build a ListTile for each kategori
                for (var entry in groupedData.entries)
                  ListTile(
                    title: Text(entry.key),
                    subtitle: Text(
                      '${entry.value.length}',
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildJenisPerizinanView() {
    return FutureBuilder(
      future: fetchData(''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return _buildErrorView();
        } else {
          List<dynamic> data = snapshot.data ?? [];

          // Group data by 'surat_jenis'
          Map<String, List<dynamic>> groupedData = {};
          for (var item in data) {
            String jenisPerizinan = item['surat_jenis']['nama'] as String;
            if (!groupedData.containsKey(jenisPerizinan)) {
              groupedData[jenisPerizinan] = [];
            }
            groupedData[jenisPerizinan]!.add(item);
          }

          return Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jenis Perizinan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                // Build a ListTile for each jenis perizinan
                for (var entry in groupedData.entries)
                  ListTile(
                    title: Text(entry.key),
                    subtitle: Text(
                      '${entry.value.length}',
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 250, child: _head()),
          Padding(
            padding: EdgeInsets.only(top: 32, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard Perizinan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusView(
            title: 'Pengajuan Masuk',
            statusFilter: '',
          ),
          _buildStatusView(
            title: 'Pengajuan Diterima',
            statusFilter: 'Selesai',
          ),
          _buildStatusView(
            title: 'Pengajuan Ditolak',
            statusFilter: 'Ditolak',
          ),
          _buildStatusView(
            title: 'Proses Survey',
            statusFilter: 'Penjadwalan Survey',
          ),
          _buildKategoriPerizinanView(), // Ganti kategori sesuai kebutuhan Anda
          _buildJenisPerizinanView()
        ],
      ),
    );
  }

  Widget _head() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 218,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/topberanda.png"),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 23,
                    left: 250,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(RouteNames.notifikasi),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: appbrand100,
                          child: const Icon(
                            Icons.notifications,
                            color: appbrand500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 23,
                    left: 300,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(RouteNames.chat),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: appbrand100,
                          child: const Icon(
                            Icons.chat,
                            color: appbrand500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 23,
                    left: 350,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(RouteNames.scan),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: appbrand100,
                          child: const Icon(
                            Icons.qr_code_scanner,
                            color: appbrand500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 36),
                    child: Text(
                      "Hai ${editProfileController.namaLengkapController.text}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 120,
          left: 25,
          child: Container(
            height: 128,
            width: 328,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appbrand500,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 25,
                  spreadRadius: -5,
                  offset: const Offset(0, 9),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nikmati Kemudahan\nPerizinan Sekolah",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: appwhite,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/beranda.icon.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 100,
                      height: 100,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
