import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';
import 'package:urbanscholaria_app/widgets/button.dart';
import 'package:urbanscholaria_app/widgets/inputdata_card.dart';

class AjukanPerizinanFileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController ktpController = TextEditingController();
    // Get values from arguments
    final Map<String, dynamic> args = Get.arguments;
    print("Arguments: $args");

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
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Map<String, dynamic> detailJenisPerizinan = snapshot.data!;
                BerandaController berandaController = Get.find();

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
                          color: appbrand50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText:
                                      'KTP/Surat Keterangan\nDomisili Penanggung Jawab',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'BPJS Ketenagakerjaan',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'BPJS Kesehatan',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'Foto Gambar/Denah Tanah',
                                  subTitle: 'Format: JPG/PNG (Max 3mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText:
                                      'Upload Surat Kuasa Pengurusan\nPerizinan',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'Riwayat Hidup Penanggung Jawab',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'Nomor Induk Berusaha (NIB)',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'Nomor Pokok Wajib Pajak (NPWP)',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'Hasil Penilaian Kelayakan',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'Akta Tanah/Surat Kepemilikan',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText:
                                      'Surat Keterangan Izin dari\nRT/RW atau Setempat',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText:
                                      'Data mengenai Perkiraan Pembiayaan\nUntuk Kelangsungan Pendidikan',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText: 'Program Kerja',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                              PermissionWidget(
                                viewModel: PermissionViewModel(
                                  hintText:
                                      'Profil Rencana Pengembangan\n(dalam 5 tahun)',
                                  subTitle: 'Format: PDF (Max 1mb)',
                                ),
                                onFilePicked: (title, filePath) {
                                  ktpController.text = filePath;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonWidgets(label: "Ajukan Perizinan")
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}

Future<Map<String, dynamic>> getDetailJenisPerizinan() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int jenisSuratId = prefs.getInt('selected_jenis_surat_id') ?? 0;

  TKPerizinanController controller = Get.find();
  return controller.getDetailJenisPerizinan(jenisSuratId);
}
