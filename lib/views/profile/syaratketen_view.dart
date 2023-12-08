import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class SyaratDanKetentuanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("Syarat dan Ketentuan"),
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang di Urban Scholaria',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: appneutral800),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Syarat dan Ketentuan dari Aplikasi Urban Scholaria :\n',
              style: TextStyle(fontSize: 14.0, color: appneutral500),
            ),
            Text(
              'Pendaftaran pengguna :\n'
              '1. Pengguna wajib melakukan pendaftaran menggunakan informasi pribadi yang akurat dan sesuai dengan identitas resmi berdasarkan undang-undang keamanan data.\n'
              '2. Pengguna bertanggung jawab atas keamanan akun dan dilarang untuk memberikan informasi login kepada pihak lain.\n'
              '3. Pendaftaran harus mematuhi peraturan privasi data dan perlindungan konsumen yang berlaku.\n\n'
              'Pengajuan perizinan :\n'
              '1. Pengguna berhak mengajukan perizinan pembangunan, operasional, atau perubahan operasional pada bangunan pendidikan dari tingkat TK hingga SMA melalui syarat dan formulir yang telah disediakan.\n'
              '2. Dokumen yang diunggah harus mencakup Surat Permohonan, Rencana Tata Letak Bangunan, Sertifikat Tanah, dan dokumen pendukung lainnya sesuai regulasi.\n\n'
              // Lanjutkan dengan poin-poin lainnya...
              'Pemberitahuan dan komunikasi :\n'
              '1. Pemberitahuan resmi mengenai status pengajuan, perubahan, atau informasi penting akan disampaikan melalui notifikasi dalam aplikasi.\n'
              '2. Pengguna diharapkan untuk secara aktif memantau notifikasi dan mematuhi petunjuk yang diberikan.\n\n'
              'Tindakan pelanggaran :\n'
              '1. Pelanggaran terhadap S&K dapat mengakibatkan sanksi, penangguhan, atau penghapusan akses pengguna ke aplikasi.\n'
              '2. Pihak berwenang berhak mengambil tindakan hukum jika ditemukan pelanggaran undang-undang dalam penggunaan aplikasi.\n\n'
              // Lanjutkan dengan poin-poin lainnya...
              'Pembaruan syarat dan ketentuan :\n'
              '1. Pihak penyelenggara berhak untuk melakukan pembaruan terhadap S&K tanpa pemberitahuan sebelumnya.\n'
              '2. Pengguna diharapkan secara berkala memeriksa dan memahami S&K yang berlaku untuk tetap mematuhi regulasi terbaru.\n\n'
              'Kepatuhan hukum :\n'
              '1. Penggunaan aplikasi ini harus mematuhi semua undang-undang dan peraturan yang berlaku di wilayah hukum terkait.\n'
              '2. Pihak berwenang berhak mengambil tindakan jika ditemukan pelanggaran terhadap ketentuan hukum.\n\n',
              style: TextStyle(fontSize: 12.0, color: appneutral500),
            ),
            Text(
              'Dengan menggunakan aplikasi ini, pengguna dianggap telah membaca, memahami, dan menyetujui seluruh Syarat & Ketentuan yang telah ditetapkan. Keseluruhan S&K ini dirancang untuk memberikan panduan yang jelas, transparan, dan sesuai dengan undang-undang dalam proses administrasi pelayanan pendidikan.',
              style: TextStyle(fontSize: 12.0, color: appneutral500),
            ),
          ],
        ),
      ),
    );
  }
}
