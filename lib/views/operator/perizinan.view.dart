import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OperatorPerizinanView extends StatefulWidget {
  @override
  _OperatorPerizinanViewState createState() => _OperatorPerizinanViewState();
}

class _OperatorPerizinanViewState extends State<OperatorPerizinanView> {
  List<Map<String, dynamic>> perizinanData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final Uri uri = Uri.parse('https://urbanscholaria.my.id/api/surat');
      final response = await http.get(uri);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Perizinan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Cari Perizinan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Aksi filter
                  },
                  child: Text('Filter'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Jumlah Perizinan: ${perizinanData.length}'),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID Dokumen')),
                  DataColumn(label: Text('Nama Pemohon')),
                  DataColumn(label: Text('Perizinan')),
                  DataColumn(label: Text('Tanggal Perizinan')),
                  DataColumn(label: Text('Dokumen')),
                  DataColumn(label: Text('Aksi')),
                ],
                rows: perizinanData.map((data) {
                  return DataRow(
                    cells: [
                      DataCell(Text(data['id'].toString())),
                      DataCell(Text(data['user']['nama_lengkap'])),
                      DataCell(Text(data['surat_jenis']['nama'])),
                      DataCell(Text(data['created_at'])),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            // Aksi Unduh
                          },
                          child: Text('Unduh'),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
