import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';
import 'package:urbanscholaria_app/widgets/button.dart';
import 'package:urbanscholaria_app/widgets/inputdata_card.dart';

class AjukanPerizinanFileView extends StatelessWidget {
  final TextEditingController ktpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final int suratId = args['surat_id'];
    final int suratJenisId = args['surat_jenis_id'];
    final int suratSyaratId = args['surat_syarat_id'];

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
          future: getDetailJenisPerizinan(suratJenisId),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Map<String, dynamic> detailJenisPerizinan = snapshot.data!;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        '${detailJenisPerizinan['nama']}',
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
                        color: appbrand50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            PermissionWidget(
                              viewModel: PermissionViewModel(
                                hintText: 'Pilih Foto KTP',
                                subTitle:
                                    'Pilih foto KTP untuk verifikasi identitas',
                              ),
                              onFilePicked: (title, filePath) {
                                ktpController.text = filePath;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Panggil metode uploadDocument untuk mengunggah dokumen
                        uploadDocument(suratId, suratJenisId, suratSyaratId);
                      },
                      child: ButtonWidgets(
                        label: "Selanjutnya",
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getDetailJenisPerizinan(int suratJenisId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    TKPerizinanController controller = Get.find();
    return controller.getDetailJenisPerizinan(suratJenisId);
  }

  // Metode untuk mengunggah dokumen
  void uploadDocument(suratId, suratJenisId, suratSyaratId) async {
    try {
      TKPerizinanController controller = Get.find();

      // Panggil metode uploadDocument untuk mengunggah dokumen
      await controller.uploadDocument(
        suratId: suratId,
        suratJenisId: suratJenisId,
        suratSyaratId: suratSyaratId,
        filePath: ktpController.text,
      );

      // Lakukan navigasi atau tindakan lainnya setelah mengunggah dokumen
    } catch (error) {
      // Tangani kesalahan jika terjadi
      print('Error uploading document: $error');
    }
  }
}
