import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/detailjenisperizinan_c.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';

class DetailJenisPerizinanView extends StatelessWidget {
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
                                detailJenisPerizinan['nama'],
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
    String _getImagePath(String category) {
      switch (category) {
        case 'TK':
          return 'assets/icons/tk.png';
        case 'SD':
          return 'assets/icons/sd.png';
        case 'SMP':
          return 'assets/icons/smp.png';
        case 'SMA':
          return 'assets/icons/sma.png';
        default:
          return 'assets/icons/default.png'; // Gambar default jika tidak cocok dengan kategori tertentu
      }
    }

    // Call the controller method to get detailed information
    TKPerizinanController controller = Get.find();
    return controller.getDetailJenisPerizinan(jenisSuratId);
  }

  String _getImagePath(String category) {
    switch (category) {
      case 'TK':
        return 'assets/icons/tk.png';
      case 'SD':
        return 'assets/icons/sd.png';
      case 'SMP':
        return 'assets/icons/smp.png';
      case 'SMA':
        return 'assets/icons/sma.png';
      default:
        return 'assets/icons/default.png'; // Gambar default jika tidak cocok dengan kategori tertentu
    }
  }
}
