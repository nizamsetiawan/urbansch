import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OperatorDashboardView extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("OPERATOR DASHBOARD"),
        centerTitle: true,
        elevation: 0,
      ),
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
            statusFilter: 'Pengajuan Masuk',
          ),
          _buildStatusView(
            title: 'Pengajuan Diterima',
            statusFilter: 'Pengajuan Diterima',
          ),
          _buildStatusView(
            title: 'Pengajuan Ditolak',
            statusFilter: 'Pengajuan Ditolak',
          ),
          _buildStatusView(
            title: 'Pengajuan Terlambat',
            statusFilter: 'Pengajuan Terlambat',
          ),
          _buildStatusView(
            title: 'Proses Survey',
            statusFilter: 'Proses Survey',
          ),
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
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // ... (existing code)

                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 36),
                    child: Text(
                      "Hai Operator", // Ganti dengan sesuatu yang sesuai
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
              color: Colors.blue, // Sesuaikan dengan warna yang diinginkan
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
                          "Verifikasi Perizinan\ndi Urban Scholaria",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
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
                          image:
                              AssetImage("assets/icons/operatordashboard.png"),
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
