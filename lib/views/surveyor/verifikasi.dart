import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/views/verifikator/detailscreenverifikasi.dart';

class SurveyorVerifikasiView extends StatefulWidget {
  const SurveyorVerifikasiView({Key? key}) : super(key: key);

  @override
  State<SurveyorVerifikasiView> createState() => _VerifikasiViewState();
}

class _VerifikasiViewState extends State<SurveyorVerifikasiView> {
  List<Map<String, dynamic>> perizinanData = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    try {
      final String queryParameters =
          '?status=Verifikasi%20Verifikasi Hasil Survey';

      final Uri uri =
          Uri.parse('https://urbanscholaria.my.id/api/surat$queryParameters');

      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        setState(() {
          perizinanData = List.from(responseData);
        });

        // Print the response data
        print('Response Data: $perizinanData');

        // Print the request URL
        print('Request URL: $uri');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // Function to filter perizinan by ID
  List<Map<String, dynamic>> filterPerizinanById(String id) {
    return perizinanData
        .where((data) => data['id'].toString().contains(id))
        .toList();
  }

  // Function to reset the data to the initial state
  Future<void> resetData() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("TUGAS SURVEY"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          // If search field is empty, reset data
                          if (value.isEmpty) {
                            resetData();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari Perizinan...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Aksi filter berdasarkan ID
                    String id = searchController.text;
                    List<Map<String, dynamic>> filteredData =
                        filterPerizinanById(id);
                    setState(() {
                      perizinanData = filteredData;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: appbrand500,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Cari'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Jumlah Perizinan: ${perizinanData.length},',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: appneutral500),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Status')),
                  DataColumn(
                      label: Row(
                    children: [
                      Icon(
                        Icons.file_copy_outlined,
                        color: appbrand500,
                        size: 16,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Verifikasi'),
                    ],
                  )),
                ],
                rows: perizinanData
                    .map<DataRow>((data) => DataRow(
                          cells: [
                            DataCell(Text(data['id'].toString())),
                            DataCell(
                              _buildStatusText(data['status']),
                            ),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailVerifikasiVerifikatorView(
                                        requestData: data,
                                        namaLengkap: data['user']
                                                ['nama_lengkap'] ??
                                            'Nama Lengkap Tidak Tersedia',
                                      ), // Sesuaikan dengan class dan parameter yang diperlukan
                                    ),
                                  );
                                },
                                child: Text(
                                  'Lihat Kelengkapan',
                                  style: TextStyle(
                                      color:
                                          appbrand500, // Ubah warna teks sesuai kebutuhan
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStatusText(String status) {
  Color statusColor = Colors.black; // Default color

  if (status == 'Verifikasi Hasil Survey') {
    status = 'Perlu Survey';
    statusColor = appwarn600;
  }

  return RichText(
    text: TextSpan(
      text: status,
      style: TextStyle(
        color: statusColor,
      ),
    ),
  );
}
