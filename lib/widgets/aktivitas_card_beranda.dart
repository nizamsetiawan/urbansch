import 'package:flutter/material.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class CardActivity extends StatelessWidget {
  final String? statuspengajuan;
  final String? jumlahpengajuan;
  final String? iconPath;

  const CardActivity({
    this.statuspengajuan,
    this.jumlahpengajuan,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    Color jumlahPengajuanColor =
        Colors.black; // Warna default untuk jumlah pengajuan

// Set warna berdasarkan jenis status
    if (statuspengajuan == 'Diajukan') {
      jumlahPengajuanColor =
          Colors.orange; // Warna jumlah pengajuan untuk status 'Diajukan'
    } else if (statuspengajuan == 'Ditolak') {
      jumlahPengajuanColor =
          Colors.red; // Warna jumlah pengajuan untuk status 'Ditolak'
    } else if (statuspengajuan == 'Diterima') {
      jumlahPengajuanColor =
          Colors.green; // Warna jumlah pengajuan untuk status 'Diterima'
    }

    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: appneutral300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '${iconPath}',
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${statuspengajuan}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: appbrand800, // Warna default untuk status
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${jumlahpengajuan}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: jumlahPengajuanColor, // Warna untuk jumlah pengajuan
            ),
          ),
          Text(
            "Pengajuan",
            style: TextStyle(
              fontSize: 10,
              color: appbrand800, // Warna default untuk "Pengajuan"
            ),
          )
        ],
      ),
    );
  }
}
