import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/widgets/button.dart';
import 'package:urbanscholaria_app/widgets/null.dart';

class OperatorPerizinanView extends StatefulWidget {
  @override
  _OperatorPerizinanViewState createState() => _OperatorPerizinanViewState();
}

class _OperatorPerizinanViewState extends State<OperatorPerizinanView> {
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
      // final String queryParameters = '?status=Verifikasi%20Operator';
      final String queryParameters = '?status=Selesai';
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
        title: const Text("DATA PERIZINAN"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200], // Customize the background color
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
                    primary: appbrand500, // Background color
                    onPrimary: Colors.white, // Text color
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
              child: Column(children: [
                ...perizinanData.map((data) {
                  return AdminCard(data: data);
                }).toList(),

                // Display NullValueWidget when no data is found
                if (perizinanData.isEmpty || perizinanData.first.isEmpty)
                  nullvalue(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final Map<String, dynamic> data;

  AdminCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final suratJenis = data['surat_jenis'] as Map<String, dynamic>?;
    final DateTime tanggalPerizinan = DateTime.parse(data['created_at']);

    return Card(
      color: appbrand50,
      margin: EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'ID Dokumen: ${data['id']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Nama Pemohon: ${data['user']['nama_lengkap']}',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Perizinan: ${suratJenis?['nama'] ?? 'Nama Tidak Tersedia'}',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tanggal Perizinan: ${DateFormat('dd MMMM yyyy').format(tanggalPerizinan)}',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                String suratId = data['id'].toString();
                downloadFile(suratId);
              },
              child: ButtonWidgets(
                label: "Unduh",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void downloadFile(String suratId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('access_token') ?? '';

  try {
    final response = await http.get(
      Uri.parse('https://urbanscholaria.my.id/api/surat/$suratId/cetak-surat'),
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
