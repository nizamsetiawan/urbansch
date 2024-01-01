import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/profile_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/aktivitas_card_beranda.dart';
import 'package:urbanscholaria_app/widgets/kategori_card_beranda.dart';
import 'package:urbanscholaria_app/widgets/null.dart';
import 'package:urbanscholaria_app/widgets/result_card.dart';

class BerandaView extends StatefulWidget {
  BerandaView({Key? key}) : super(key: key);

  @override
  State<BerandaView> createState() => _BerandaViewState();
}

class _BerandaViewState extends State<BerandaView> {
  final BerandaController controller = Get.put(BerandaController());

  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  int? _userId;

  @override
  void initState() {
    super.initState();
    getUserId().then((value) {
      setState(() {
        _userId = value;
        print(_userId);
      });
    });
  }

  final TextEditingController searchController = TextEditingController();

  Future<List<dynamic>> fetchData(String statusFilter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    try {
      final response = await http.get(
        Uri.parse(
            'https://urbanscholaria.my.id/api/surat/$_userId?status=$statusFilter'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('API Response Data: $responseData');

        List<dynamic> data = responseData['data'] ?? [];
        return data;
      } else {
        print('Gagal mengambil data. Kode status: ${response.statusCode}');
        throw Exception('Gagal mengambil data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw Exception('Error fetching data: $error');
    }
  }

  Future<Map<String, dynamic>> fetchUserDataById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    try {
      final response = await http.get(
        Uri.parse('https://urbanscholaria.my.id/api/surat?id_surat=$id'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Data ditemukan: $responseData');
        return responseData;
      } else {
        print('Failed to fetch user data. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
      throw Exception('Error fetching user data: $error');
    }
  }

  final List<String> statusFilters = [
    'Verifikasi Operator', // Diajukan
    'Selesai', // Diterima
    'Ditolak', // Ditolak
  ];

  int getJumlahPengajuan(String status) {
    if (status == 'Verifikasi Operator') {
      print('Count for Diajukan: ${controller.dataDiajukan.length}');
      return controller.dataDiajukan.length;
    } else if (status == 'Diterima') {
      print('Count for Diterima: ${controller.dataDiterima.length}');
      return controller.dataDiterima.length;
    } else if (status == 'Ditolak') {
      print('Count for Ditolak: ${controller.dataDitolak.length}');
      return controller.dataDitolak.length;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 250, child: _head()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 32, left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aktivitas",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: appneutral500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatusView(
                            title: 'Diajukan',
                            statusFilter: 'Verifikasi Operator',
                          ),
                          _buildStatusView(
                            title: 'Diterima',
                            statusFilter: 'Selesai',
                          ),
                          _buildStatusView(
                            title: 'Ditolak',
                            statusFilter: 'Ditolak',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Lacak Permohonan Anda",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      child: Container(
                        width: 240,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: appneutral400),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: "ID Pengajuan",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () async {
                                String searchId = searchController.text;

                                try {
                                  Map<String, dynamic> userData =
                                      await fetchUserDataById(searchId);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: userData != null &&
                                                userData.isNotEmpty
                                            ? UserCard(userData: userData)
                                            : nullvalue(),
                                      );
                                    },
                                  );
                                } catch (error) {
                                  print('Error fetching user data: $error');

                                  // Check if the error is due to user data not found
                                  if (error
                                      .toString()
                                      .contains('Failed to fetch user data')) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: nullvalue(),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kategori Perizinan",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      controller.handleCategoryTap('TK'),
                                  child: KategoriPerizinan(
                                    label: 'Perizinan TK',
                                    iconPath: 'assets/icons/tk.png',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      controller.handleCategoryTap('SD'),
                                  child: KategoriPerizinan(
                                    label: 'Perizinan SD',
                                    iconPath: 'assets/icons/sd.png',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      controller.handleCategoryTap('SMP'),
                                  child: KategoriPerizinan(
                                    label: 'Perizinan SMP',
                                    iconPath: 'assets/icons/smp.png',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      controller.handleCategoryTap('SMA'),
                                  child: KategoriPerizinan(
                                    label: 'Perizinan SMA',
                                    iconPath: 'assets/icons/sma.png',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ... (your existing code)
  Widget _buildStatusView({
    required String title,
    required String statusFilter,
  }) {
    Color statusColor = Colors.black; // Default color

    // Set color based on status
    if (statusFilter == 'Verifikasi Operator') {
      statusColor = Colors.yellow; // Yellow for 'Pengajuan Masuk'
    } else if (statusFilter == 'Selesai') {
      statusColor = Colors.green; // Green for 'Pengajuan Diterima'
    } else if (statusFilter == 'Ditolak') {
      statusColor = Colors.red; // Red for 'Pengajuan Ditolak'
    } else if (statusFilter == 'Penjadwalan Survey') {
      statusColor = Colors.blue; // Blue for 'Proses Survey'
    }

    return FutureBuilder(
      future: fetchData('?status=$statusFilter&user_id=$_userId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("");
        } else {
          List<dynamic> data = snapshot.data ?? [];

          // Filter only data with the specified status
          data = data.where((item) => item['status'] == statusFilter).toList();

          int totalCount = data.length;

          return Container(
            width: 70,
            margin: EdgeInsets.all(5),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '$totalCount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: statusColor,
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

  // ... (your existing code)
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
