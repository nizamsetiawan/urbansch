import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/models/kategori_m.dart';

class TKPerizinanController extends GetxController {
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

    // Print token for verification
    print('Access Token: $token');

    String? selectedCategory = prefs.getString('selected_category');

    if (selectedCategory == null) {
      // Handle the case where no category is selected
      return;
    }

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

      // Hapus filter .where sementara
      permitstk.assignAll(jenisSuratList.map((jenisSurat) {
        return TKCardPerizinan(
          title: jenisSurat.nama,
          requirements: '13 Syarat Dokumen',
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

  void handleDropdownClick(String selectedCategory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_category', selectedCategory);

    // Print selected category for verification
    print('Selected Category: $selectedCategory');
  }

  void navigateToDetail(JenisSurat jenisSurat) {
    // Tambahkan navigasi sesuai kebutuhan Anda
    // Get.toNamed(RouteNames.detailPage, arguments: jenisSurat);
  }
}
