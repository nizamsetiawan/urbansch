import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("Kontak dan Tentang"),
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
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang Urban Scholaria',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: Image.asset("assets/icons/daftar.png")),
            SizedBox(height: 20.0),
            Text(
              'Selamat datang di aplikasi Urban Scholaria.\n\n'
              'Urban Scholaria merupakan sebuah aplikasi yang terintegrasi website dan mobile '
              'yang dikembangkan oleh perusahaan Urban Labs untuk mengajukan sebuah perizinan '
              'online berkategori pendidikan. Aplikasi ini bertujuan untuk mempermudah pemohon '
              'untuk mengajukan perizinan online berupa :\n\n'
              '1. Pengajuan permohonan perizinan bangunan pendidikan tingkat TK hingga SMA\n'
              '2. Pengajuan permohonan perizinan operasional bangunan pendidikan tingkat TK hingga SMA\n'
              '3. Pengajuan permohonan perizinan perubahan operasional bangunan pendidikan tingkat TK hingga SMA\n\n'
              'Aplikasi ini juga dirancang untuk memfasilitasi proses administrasi perizinan yang '
              'lebih efisien, menghilangkan hambatan – hambatan yang seringkali menghambat '
              'perkembangan pendidikan. Urban Labs berkomitmen untuk meningkatkan kualitas pendidikan '
              'dengan menyediakan solusi yang terintegrasi dan mudah di akses. Selain itu juga, kami '
              'mempunyai 5 poin tujuan khusus kami, yakni :\n\n'
              '1. Peningkatan Literasi Digital\n'
              '2. Pengukuran Kinerja dan Umpan Balik\n'
              '3. Kemudahan Pelaporan\n'
              '4. Penghematan Sumber Daya\n'
              '5. Peningkatan Keakuratan Data\n\n',
              style: TextStyle(fontSize: 12.0, color: appneutral600),
            ),
            Text(
              "Informasi Kontak",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 17,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: appbrand500,
                  size: 20,
                ),
                SizedBox(
                  width: 15,
                ),
                Text("+2034 4040 3030",
                    style: TextStyle(fontSize: 12, color: appneutral600)),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Icon(
                  Icons.mail,
                  color: appbrand500,
                  size: 20,
                ),
                SizedBox(
                  width: 15,
                ),
                Text("urban.labs@gmail.com",
                    style: TextStyle(fontSize: 12, color: appneutral600)),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.instagram,
                  size: 18.0,
                  color: appbrand500,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "@urbanlabs",
                  style: TextStyle(fontSize: 12, color: appneutral600),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: appbrand500,
                  size: 20,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                    "Jl. Lidah Wetan, Ketintang, Gayungan,\nSurabaya, East Java 60231",
                    style: TextStyle(fontSize: 12, color: appneutral600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
