import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
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
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    initializeData();
    tkController = Get.put(TKPerizinanController());
    tkController.suratSyarats.forEach((_) {
      controllers.add(TextEditingController());
    });
  }

  Future<void> initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    suratId = prefs.getInt('suratId') ?? 0;
    setState(() {});
  }

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
        final Map<String, dynamic> responseData =
            await http.Response.fromStream(response)
                .then((value) => json.decode(value.body));

        if (responseData.containsKey('message')) {
          print('Document uploaded successfully: ${responseData['message']}');
        } else {
          print('Unexpected response format from API');
        }
      } else {
        print('Document upload failed. Status code: ${response.statusCode}');
        print('Response Body: ${await response.stream.bytesToString()}');
      }
    } catch (error) {
      print('Error uploading document: $error');
    }
  }

  Future<void> patchSuratDiajukan(int suratId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        return;
      }

      final url = Uri.parse(BASE_API + 'api/surat/$suratId/surat-diajukan');

      var response = await http.patch(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('message')) {
          print('Surat diajukan successfully: ${responseData['message']}');
        } else {
          print('Unexpected response format from API');
        }
      } else {
        print('Surat diajukan failed. Status code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error submitting surat diajukan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                    controllers[index].text = filePath;
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
                      onTap: () => Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: appbrand50,
                          title: const Text('Ketentuan & Pernyataan'),
                          titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: appneutral800,
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Menyatakan\n'
                                '1. Bersedia mengikuti seluruh proses pengajuan perizinan dari awal sampai selesai.\n'
                                '2. Bersedia memenuhi persyaratan administratif serta syarat dan ketentuan yang berlaku.\n'
                                '3. Bersedia menaati segala ketentuan dan tata tertib yang telah ditentukan.\n'
                                '4. Mengerti dan setuju bahwa aplikasi ini hanya digunakan untuk kebutuhan pengajuan administratif pengajuan di bidang pendidikan.\n'
                                '5. Bersedia memberikan informasi pribadi yang tercantum dalam form pendaftaran.\n'
                                '6. Setuju dan mengerti apabila dokumen pengajuan yang diajukan tidak sesuai sehingga pengajuan akan ditolak.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: appneutral500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() => CheckboxListTile(
                                    activeColor: appbrand500,
                                    title: const Text(
                                      'Saya telah bersedia mengikuti ketentuan yang ada pada pernyataan perizinan ini.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: appneutral500,
                                      ),
                                    ),
                                    value: tkController.isChecked.value,
                                    onChanged: (newValue) {
                                      tkController.isChecked.value =
                                          newValue ?? false;
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  )),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  print(
                                      'Sebelum uploadDocumentToAPI: suratId: $suratId, suratSyaratIds: $suratSyaratIds');
                                  for (var i = 0;
                                      i < suratSyaratIds.length;
                                      i++) {
                                    await uploadDocumentToAPI(
                                      suratId: suratId,
                                      suratJenisId: detailJenisPerizinan['id'],
                                      suratSyaratId: suratSyaratIds[i],
                                      dokumenPath: controllers[i].text,
                                    );
                                  }

                                  print('Setelah uploadDocumentToAPI');

                                  if (tkController.isChecked.value) {
                                    AwesomeDialog(
                                      padding: const EdgeInsets.all(15),
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      title:
                                          'Terima Kasih! Permohonanmu sudah kami terima',
                                      titleTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: appbrand500,
                                      ),
                                      desc:
                                          'Pengajuan permohonan pengajuan perizinan telah kami terima dan akan melewati tahapan perizinan. Kamu bisa melihat permohonan mu di menu riwayat dan bisa melacak tiap tahapan perizinan dengan ID Dokumen dan Scan Barcode.',
                                      descTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: appneutral600,
                                      ),
                                      btnOkOnPress: () {
                                        Get.offAllNamed(
                                            RouteNames.bottomnavigation);
                                      },
                                      btnOkText: "Selesai",
                                    )..show();
                                    try {
                                      await patchSuratDiajukan(suratId);
                                    } catch (error) {
                                      print('Error submitting form: $error');
                                    }
                                  } else {
                                    Get.snackbar('Perhatian',
                                        'Harap setujui pernyataan perizinan terlebih dahulu',
                                        backgroundColor: appneutral50);
                                  }
                                },
                                child: const ButtonWidgets(
                                  label: "Ajukan Perizinan",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      child: const ButtonWidgets(
                        label: "Selanjutnya",
                      ),
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
