import 'package:flutter/material.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class OperatorDashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 250, child: _head()),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hai Regi!',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '2',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Verifikasi Perizinan',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'di Urban Scholaria',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Dashboard Perizinan',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Laporan',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                              items: [
                                'Semua',
                                'Hari Ini',
                                'Seminggu',
                                'Sebulan',
                                '3 Bulan',
                                '1 Tahun',
                                '3 Tahun'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // Handle dropdown item selection
                              },
                              value: 'Semua',
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        buildStatCard('Pengajuan Masuk', '200', '10%',
                            'dari bulan kemarin'),
                        buildStatCard('Pengajuan Diterima', '150', '8%',
                            'dari bulan kemarin'),
                        buildStatCard('Pengajuan Ditolak', '25', '10%',
                            'dari bulan kemarin'),
                        buildStatCard('Pengajuan Terlambat', '5', '10%',
                            'dari bulan kemarin'),
                        buildStatCard(
                            'Proses Survey', '20', '10%', 'dari bulan kemarin'),
                        SizedBox(height: 16),
                        Text(
                          'Kategori Perizinan',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        buildCategoryCard('Pembangunan', '100'),
                        buildCategoryCard('Operasional', '50'),
                        buildCategoryCard('Perubahan Operasional', '50'),
                        SizedBox(height: 16),
                        Text(
                          'Trend Pengajuan Pertahun',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        buildYearlyTrendCard('2023', '100'),
                        buildYearlyTrendCard('2022', '50'),
                        buildYearlyTrendCard('2021', '50'),
                        SizedBox(height: 16),
                        Text(
                          'Trend Pengajuan Perkota/Kabupaten di Jawa Timur',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        buildCityTrendCard('Kota Surabaya', '40'),
                        buildCityTrendCard('Kota Pasuruan', '25'),
                        buildCityTrendCard('Kota Madiun', '15'),
                        buildCityTrendCard('Kota Blitar', '10'),
                        buildCityTrendCard('Kota Mojokerto', '10'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatCard(
      String title, String value, String percentage, String subtitle) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  percentage,
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
                SizedBox(width: 8),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCard(String category, String value) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildYearlyTrendCard(String year, String value) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              year,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCityTrendCard(String city, String value) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              city,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
                    left: 300,
                    child: GestureDetector(
                      // onTap: () => Get.toNamed(RouteNames.notifikasi),
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
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 36),
                    child: Text(
                      "Hai Operator! ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
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
                  offset: const Offset(0, 9), // mengubah posisi bayangan
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
                              color: appwhite),
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
                            fit: BoxFit.cover),
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
