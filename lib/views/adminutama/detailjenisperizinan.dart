import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/detailjenisperizinan_c.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class AdminUtamaDetailJenisPerizinanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDetailJenisPerizinan(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Display the detailed information here
          Map<String, dynamic> detailJenisPerizinan = snapshot.data!;
          DetailJenisPerizinanController controller =
              Get.put(DetailJenisPerizinanController()); // Get the controller
          TKPerizinanController tkcontroller = Get.put(TKPerizinanController());
          BerandaController berandaController = Get.find(); // Tambahkan ini

          return Scaffold(
            appBar: AppBar(
              backgroundColor: appbrand500,
              title: Text("INFORMASI PERIZINAN"),
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${detailJenisPerizinan['nama']} ${berandaController.getSelectedCategory}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        Image.asset("assets/icons/beranda.icon.png"),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Deskripsi Perizinan",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: appneutral800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.detailjenis.value.subDeskripsiPerizinan,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: appneutral500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Legalitas Perizinan",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: appneutral800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.detailjenis.value.subLegalitasPerizinan,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: appneutral500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Persyaratan Pemohon",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: appneutral800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.detailjenis.value.subPersyaratanPemohon
                          .join('\n'),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: appneutral500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Catatan :",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: appneutral800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.detailjenis.value.noted,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: appneutral500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: GestureDetector(
                            onTap: () {
                              // Show an expanded image in a pop-up
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Image.asset(
                                      "assets/images/alurperizinan.png",
                                      width: 300,
                                      height: 300,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              color: appbrand100,
                              child: Icon(
                                Icons.sort,
                                color: appbrand500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Alur Perizinan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: appneutral800,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "lihat alur perizinan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: appneutral500,
                                ),
                              ),
                              Divider(
                                color: appneutral500,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: appbrand100,
                            child: Icon(
                              Icons.timer,
                              color: appbrand500,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Waktu Proses Kerja",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: appneutral800,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                controller
                                    .detailjenis.value.subProsesWaktuKerja,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: appneutral500,
                                ),
                              ),
                              Divider(
                                color: appneutral500,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // ...

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: GestureDetector(
                            onTap: () {
                              // Menampilkan dialog dengan persyaratan
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Persyaratan Perizinan ${berandaController.getSelectedCategory}"),
                                    content: Container(
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                        itemCount:
                                            tkcontroller.suratSyarats.length,
                                        itemBuilder: (context, index) {
                                          final syarat =
                                              tkcontroller.suratSyarats[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${index + 1}. ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(syarat['nama']),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              color: appbrand100,
                              child: Icon(
                                Icons.assignment,
                                color: appbrand500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Persyaratan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: appneutral800,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Lihat Persyaratan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: appneutral500,
                                ),
                              ),
                              Divider(
                                color: appneutral500,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

// ...
                    GestureDetector(
                      onTap: () {
                        // Navigate to the form page
                        Get.toNamed(RouteNames.ajukanjenisperizinanform,
                            arguments: {
                              'category': berandaController.getSelectedCategory,
                              'jenisSuratId': detailJenisPerizinan['id'],
                            });
                      },
                      child: ButtonWidgets(
                        label: 'Ajukan Perizinan Ini',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> getDetailJenisPerizinan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int jenisSuratId = prefs.getInt('selected_jenis_surat_id') ?? 0;

    // Call the controller method to get detailed information
    TKPerizinanController controller = Get.find();
    return controller.getDetailJenisPerizinan(jenisSuratId);
  }
}
