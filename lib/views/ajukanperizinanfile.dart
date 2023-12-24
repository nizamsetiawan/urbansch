import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';
import 'package:urbanscholaria_app/widgets/button.dart';
import 'package:urbanscholaria_app/widgets/inputdata_card.dart';
import 'package:http/http.dart' as http;

class AjukanPerizinanFileView extends StatefulWidget {
  @override
  _AjukanPerizinanFileViewState createState() =>
      _AjukanPerizinanFileViewState();
}

class _AjukanPerizinanFileViewState extends State<AjukanPerizinanFileView> {
  late int suratId;
  late List<int> suratSyaratIds;
  late TKPerizinanController tkController;

  @override
  void initState() {
    super.initState();
    initializeData();
    tkController = Get.put(TKPerizinanController());
    // fetchSyaratPerizinanData();
  }

  Future<void> initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    suratId = prefs.getInt('suratId') ?? 0;
    setState(() {});
  }

  // Future<void> fetchSyaratPerizinanData() async {
  //   try {
  //     // Gantilah ini dengan panggilan API yang sebenarnya
  //     // dan perbarui tkController.suratSyarats
  //     final response = await http.get('$BASE_API/api/syarat_perizinan');
  //     final data = json.decode(response.body);
  //     tkController.suratSyarats = data['syarat_perizinan'];
  //   } catch (error) {
  //     print("Error fetching syarat perizinan data: $error");
  //   }
  // }

  Future<Map<String, dynamic>> getDetailJenisPerizinan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int jenisSuratId = prefs.getInt('selected_jenis_surat_id') ?? 0;

    TKPerizinanController controller = Get.find();
    return controller.getDetailJenisPerizinan(jenisSuratId);
  }

  Future<void> uploadDocumentToAPI({
    required int suratId,
    required int suratJenisId,
    required int suratSyaratId,
    required String dokumenPath,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        // Handle the case where the access token is not available
        return;
      }

      final url = Uri.parse(BASE_API +
          'api/surat/$suratId/surat-jenis/$suratJenisId/upload-dokumen/$suratSyaratId');

      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(
            await http.MultipartFile.fromPath('dokumen_upload', dokumenPath));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Document uploaded successfully');

        final Map<String, dynamic> responseData =
            await http.Response.fromStream(response)
                .then((value) => value.body)
                .then((value) => json.decode(value));

        if (responseData.containsKey('surat_dokumen')) {
          final List<dynamic> suratDokumen = responseData['surat_dokumen'];
          if (suratDokumen.isNotEmpty) {
            final int uploadedDocumentId = suratDokumen.first['id'];
            print('Uploaded Document ID: $uploadedDocumentId');
            // Do something with the uploaded document ID if needed
          }
        }
      } else {
        print('Document upload failed. Status code: ${response.statusCode}');
        // Print the response body for more details
        print('Response Body: ${await response.stream.bytesToString()}');
        // Handle the error
      }
    } catch (error) {
      print('Error uploading document: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController ktpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: Text("AJUKAN PERIZINAN"),
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getDetailJenisPerizinan(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic> detailJenisPerizinan = snapshot.data!;
              BerandaController berandaController = Get.find();

              suratSyaratIds = tkController.suratSyarats
                  .map((syarat) => syarat['id'] as int)
                  .toList();

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '${detailJenisPerizinan['nama']} ${berandaController.getSelectedCategory}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: 330,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: tkController.suratSyarats.length,
                              itemBuilder: (context, index) {
                                final suratSyarat =
                                    tkController.suratSyarats[index];
                                return PermissionWidget(
                                  viewModel: PermissionViewModel(
                                    hintText: suratSyarat['nama'],
                                    subTitle: 'Format: PDF (Max 1mb)',
                                  ),
                                  onFilePicked: (title, filePath) {
                                    ktpController.text = filePath;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        print(
                            'Sebelum uploadDocumentToAPI: suratId: $suratId, suratSyaratIds: $suratSyaratIds');
                        for (var suratSyaratId in suratSyaratIds) {
                          await uploadDocumentToAPI(
                            suratId: suratId,
                            suratJenisId: detailJenisPerizinan['id'],
                            suratSyaratId: suratSyaratId,
                            dokumenPath: ktpController.text,
                          );
                        }
                        print('Setelah uploadDocumentToAPI');
                      },
                      child: ButtonWidgets(label: "Ajukan Perizinan"),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
