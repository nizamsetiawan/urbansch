import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:urbanscholaria_app/models/detailjenisperizinan_m.dart';

class DetailJenisPerizinanController extends GetxController {
  var detailjenis = DetailJenisPerizinan(
    iconPerizinan: "assets/icons/tk.png",
    subDeskripsiPerizinan:
        "Pelatihan Strategi Strategi Pendanaan merupakan pelatihan bagi pelaku Usaha Mikro, Kecil, dan Menengah (UMKM) dalam rangka mempersiapkan Sumber Daya Manusia yang unggul di era revolusi industri 4.0. . Modul pembelajaran dalam kelas Strategi Pendanaan telah dirancang khusus untuk memenuhi kebutuhan pelaku UMKM terkait optimasi keuangan usaha melalui kanal digital dan strategi dalam mendapatkan pendanaan usaha. Di dalam kelas, peserta akan mendapatkan materi dalam bentuk teori, serta contoh aplikasinya dalam usaha. Lebih lanjut, peserta juga akan diberikan informasi terkait dengan berbagai solusi bisnis ekosistem Gojek untuk pelaku UMKM.",
    subLegalitasPerizinan:
        "Semua keabsahan perizinan melalui platform Urban Scholaria telah resmi disetujui dan mendapat pengakuan oleh pemerintah setempat. ",
    subPersyaratanPemohon: [
      "1. Pemohon harus merupakan Warga Negara Indonesia dan dapat membuktikannya dengan menyertakan Kartu Tanda Penduduk (KTP) atau Kartu Keluarga (KK).",
      "2. Pemohon minimal berusia 18 tahun pada saat mengajukan permohonan.",
      "3. Pemohon wajib menyertakan informasi kontak yang valid, termasuk alamat email pribadi atau email usaha yang aktif.",
      "4. Diutamakan memiliki akun media sosial yang aktif sebagai wujud keterlibatan dan komunikasi sosial.",
      "5. Diutamakan memiliki pengalaman dalam dunia pendidikan, baik sebagai pengajar, tenaga pendidik, atau memiliki peran lainnya.",
      "6. Pemohon perlu menyertakan dokumen pendukung seperti surat rekomendasi atau sertifikat pendukung yang dapat memperkuat permohonan.",
      "7. Diutamakan memiliki kemampuan digital, termasuk penggunaan teknologi informasi dan kecakapan dalam mengelola aplikasi.",
      "8. Pemohon perlu menyatakan kesiapannya untuk mengikuti proses verifikasi yang mungkin melibatkan survey lokasi atau tahapan lainnya."
    ],
    noted:
        "Mohon diingat bahwa setiap permohonan harus memastikan kepatuhan dengan regulasi terkini dan aktif berkomunikasi dengan instansi terkait. Keharusan untuk memberikan informasi yang akurat sangat penting, karena kelalaian dapat mengakibatkan penolakan permohonan. Perlu dicatat bahwa URBAN SCHOLARIA tidak memiliki kewenangan untuk mengubah keputusan pemerintah. Oleh karena itu, pemohon diharapkan mengikuti proses perizinan dengan cermat.",
    subAlurPerizinan:
        "mengisi persyaratan - verifikasi administrasi - verifikasi dokumen - survey lokasi - verifikasi hasil survey - penerbitan surat legalitas",
    subProsesWaktuKerja: "30 hari",
  ).obs;
}
