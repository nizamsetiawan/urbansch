import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:geocoding/geocoding.dart';
import 'package:urbanscholaria_app/controllers/jenisperizinan_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class AjukanPerizinanView extends StatefulWidget {
  @override
  State<AjukanPerizinanView> createState() => _AjukanPerizinanViewState();
}

class _AjukanPerizinanViewState extends State<AjukanPerizinanView> {
  // Declare controllers for the text fields
  TextEditingController kategoriController = TextEditingController();
  TextEditingController jenisPerizinanController = TextEditingController();
  TextEditingController namaSekolahController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String _output = '';

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  // Function to set initial values
  void _initializeValues() {
    locationController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String category = args['category'];
    final int jenisSuratId = args['jenisSuratId'];
    print('Category from arguments: $category');
    print("JenisSuratId: $jenisSuratId");

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

              kategoriController.text = category;
              jenisPerizinanController.text =
                  '${detailJenisPerizinan['nama']} ${berandaController.getSelectedCategory}';
              _latitudeController.text = "${_latitudeController.text}";
              _longitudeController.text = '${_longitudeController.text}';

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
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                    color: kategoriController.text.isNotEmpty
                                        ? appneutral200 // Warna abu-abu jika ada teks (diisi)
                                        : null, // Biarkan kosong jika tidak ada teks (kosong)
                                  ),
                                  child: TextField(
                                    controller: kategoriController,
                                    enabled: false,
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
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                    color: jenisPerizinanController
                                            .text.isNotEmpty
                                        ? appneutral200 // Warna abu-abu jika ada teks (diisi)
                                        : null, // Biarkan kosong jika tidak ada teks (kosong)
                                  ),
                                  child: TextField(
                                    controller: jenisPerizinanController,
                                    enabled: false,
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
                                  " Nama Sekolah",
                                  style: TextStyle(
                                      fontSize: 12, color: appneutral800),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                  ),
                                  child: TextField(
                                    controller: namaSekolahController,
                                    enabled: true,
                                    style: TextStyle(
                                        fontSize: 12, color: appneutral900),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 10),
                                      hintText: "Masukkan Nama Sekolah",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  " Alamat Sekolah",
                                  style: TextStyle(
                                      fontSize: 12, color: appneutral800),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                  ),
                                  child: TextField(
                                    controller: locationController,
                                    enabled: true,
                                    style: TextStyle(
                                        fontSize: 12, color: appneutral900),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 10),
                                      hintText: "Masukkan Alamat",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      locationFromAddress(
                                              locationController.text)
                                          .then((locations) {
                                        var output = 'No results found.';
                                        if (locations.isNotEmpty) {
                                          output = locations[0].toString();
                                          double latitude =
                                              locations[0].latitude;
                                          double longitude =
                                              locations[0].longitude;
                                          _latitudeController.text =
                                              latitude.toString();
                                          _longitudeController.text =
                                              longitude.toString();
                                        }

                                        setState(() {
                                          _output = output;
                                        });
                                      });
                                    },
                                    child: ButtonWidgets(
                                      label: 'Look up location',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Longitude",
                                  style: TextStyle(
                                      fontSize: 12, color: appneutral800),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                    color: _longitudeController.text.isNotEmpty
                                        ? appneutral200 // Warna abu-abu jika ada teks (diisi)
                                        : null, // Biarkan kosong jika tidak ada teks (kosong)
                                  ),
                                  child: TextField(
                                    controller: _longitudeController,
                                    enabled: false,
                                    style: TextStyle(
                                        fontSize: 12, color: appneutral900),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 10),
                                      hintText: "Isi Alamat Sekolah",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Latitude",
                                  style: TextStyle(
                                      fontSize: 12, color: appneutral800),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(color: appneutral400),
                                    color: _latitudeController.text.isNotEmpty
                                        ? appneutral200 // Warna abu-abu jika ada teks (diisi)
                                        : null, // Biarkan kosong jika tidak ada teks (kosong)
                                  ),
                                  child: TextField(
                                    controller: _latitudeController,
                                    enabled: false,
                                    style: TextStyle(
                                        fontSize: 12, color: appneutral900),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 10),
                                      hintText: "Isi Alamat Sekolah",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        sendFormDataToAPI();
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

  Future<Map<String, dynamic>> getDetailJenisPerizinan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int jenisSuratId = prefs.getInt('selected_jenis_surat_id') ?? 0;

    TKPerizinanController controller = Get.find();
    return controller.getDetailJenisPerizinan(jenisSuratId);
  }

  Future<void> sendFormDataToAPI() async {
    try {
      // Extract the values from the text controllers
      String kategori = kategoriController.text;
      String jenisPerizinan = jenisPerizinanController.text;
      String namaSekolah = namaSekolahController.text;
      String alamatSekolah = locationController.text;

      double latitude = double.parse(_latitudeController.text);
      double longitude = double.parse(_longitudeController.text);
      final Map<String, dynamic> args = Get.arguments;
      final int jenisSuratId = args['jenisSuratId'];
      // Access the TKPerizinanController to call the method
      TKPerizinanController controller = Get.find();

      // Call the method to send form data to the API
      await controller.sendFormDataToAPI(
        jenisSuratId: jenisSuratId,
        kategori: kategori,
        jenisPerizinan: jenisPerizinan,
        namaSekolah: namaSekolah,
        alamatSekolah: alamatSekolah,
        latitude: latitude,
        longitude: longitude,
      ); // Navigasi ke halaman "ajukanperizinanfileview" setelah berhasil mengirim data
      Get.toNamed(RouteNames.ajukanperizinanfile, arguments: {
        'jenisSuratId': jenisSuratId,
        'kategori': kategori,
      });

      // Perform any additional actions after sending the data if needed
    } catch (error) {
      // Handle errors if any
      print('Error sending form data: $error');
    }
  }
}
