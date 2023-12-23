import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/detailjenisperizinan_c.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';

class AjukanPerizinanView extends StatelessWidget {
  // Declare controllers for the text fields
  TextEditingController kategoriController = TextEditingController();
  TextEditingController jenisPerizinanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String category = args['category'];
    final int jenisSuratId = args['jenisSuratId'];
    print('Category from arguments: $category');
    print("JenisSuratId : $jenisSuratId");

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
              // Display the detailed information here
              Map<String, dynamic> detailJenisPerizinan = snapshot.data!;
              BerandaController berandaController = Get.find();

              // Set initial values for the controllers
              kategoriController.text = category;
              jenisPerizinanController.text =
                  '${detailJenisPerizinan['nama']} ${berandaController.getSelectedCategory}';

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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Kategori Perizinan",
                                  style: TextStyle(
                                      fontSize: 12, color: appneutral800),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                // Text field for Kategori Perizinan
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                  ),
                                  child: TextField(
                                    controller: kategoriController,
                                    enabled:
                                        false, // Set to false to make it non-editable
                                    style: TextStyle(
                                        fontSize: 12, color: appneutral900),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 10),
                                      hintText: "Masukkan ",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  " Jenis Perizinan",
                                  style: TextStyle(
                                      fontSize: 12, color: appneutral800),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                // Text field for Jenis Perizinan
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                  ),
                                  child: TextField(
                                    controller: jenisPerizinanController,
                                    enabled:
                                        false, // Set to false to make it non-editable
                                    style: TextStyle(
                                        fontSize: 12, color: appneutral900),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 10),
                                      hintText: "Masukkan ",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Future<Map<String, dynamic>> getDetailJenisPerizinan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int jenisSuratId = prefs.getInt('selected_jenis_surat_id') ?? 0;

    // Call the controller method to get detailed information
    TKPerizinanController controller = Get.find();
    return controller.getDetailJenisPerizinan(jenisSuratId);
  }
}
