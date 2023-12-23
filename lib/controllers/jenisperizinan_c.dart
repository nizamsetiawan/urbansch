import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/models/kategori_m.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

class TKPerizinanController extends GetxController {
  RxList<Map<String, dynamic>> suratSyarats = <Map<String, dynamic>>[].obs;
  var permitstk = <TKCardPerizinan>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      // Handle the case where the access token is not available
      return;
    }

    // Access BerandaController to get selected_category
    BerandaController berandaController = Get.find();

    // Wait for BerandaController to be initialized
    await Future.delayed(Duration(milliseconds: 100));

    String? selectedCategory = berandaController.selectedCategory.value;

    // Print selected category for verification
    print('Selected Category: $selectedCategory');

    final url = Uri.parse(BASE_API + "api/surat-jenis/");
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final jenisSuratList = (data['data'] as List)
          .map((item) => JenisSurat.fromJson(item))
          .toList();
      final tigaJenisSurat = jenisSuratList.take(3).toList();

      permitstk.assignAll(tigaJenisSurat.map((jenisSurat) {
        return TKCardPerizinan(
          title: jenisSurat.nama,
          requirements: '14 Syarat Dokumen',
          processingTime: '30 Hari Kerja',
          bannerimage: 'assets/images/perizinanbanner.png',
          onTap: () {
            navigateToDetail(jenisSurat);
          },
        );
      }));
      print(response.body);
    } else {
      throw Exception('Gagal memuat data');
    }

    // Print the resulting permitstk length
    print('Permits Length: ${permitstk.length}');
  }

  void navigateToDetail(JenisSurat jenisSurat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selected_jenis_surat_id', jenisSurat.id);

    // Print selected jenis surat ID for verification
    print('Selected Jenis Surat ID: ${jenisSurat.id}');

    Get.toNamed(RouteNames.detailjenisperizinan, arguments: jenisSurat);
  }

  Future<Map<String, dynamic>> getDetailJenisPerizinan(int jenisSuratId) async {
    final response =
        await http.get(Uri.parse(BASE_API + "api/surat-jenis/$jenisSuratId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      suratSyarats.value =
          List<Map<String, dynamic>>.from(data['data']['surat_syarats']);
      print(data);

      return data['data'];
    } else {
      throw Exception('Gagal memuat data detail jenis perizinan');
    }
  }

  Future<void> sendFormDataToAPI({
    required String kategori,
    required String jenisPerizinan,
    required String namaSekolah,
    required String alamatSekolah,
    required double latitude,
    required double longitude,
    required int jenisSuratId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');

      if (token == null) {
        // Handle the case where the access token is not available
        return;
      }

      // Access BerandaController to get selected_category
      BerandaController berandaController = Get.find();

      // Wait for BerandaController to be initialized
      await Future.delayed(Duration(milliseconds: 100));

      String? selectedCategory = berandaController.selectedCategory.value;

      // Print selected category for verification
      print('Selected Category: $selectedCategory');

      final url = Uri.parse(BASE_API + "api/surat");
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'kategori': kategori,
          // 'surat_jenis_id': jenisSuratId,
          'nama': namaSekolah,
          'surat_jenis_id': jenisSuratId,
          'alamat_lokasi': alamatSekolah,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        }),
      );

      if (response.statusCode == 200) {
        // Sukses, lakukan sesuatu jika diperlukan
        print('Data berhasil terkirim!');
        print('Response: ${response.body}');
      } else {
        // Gagal, tampilkan pesan kesalahan atau lakukan sesuatu yang sesuai
        print('Gagal mengirim data. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi
      print('Error: $error');
    }
  }
}
