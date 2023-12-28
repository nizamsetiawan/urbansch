import 'package:flutter/material.dart';

class nullvalue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/missingvalue.png', // Gantilah dengan path gambar Anda
          width: 150,
          height: 150,
          // Sesuaikan property width dan height sesuai kebutuhan
        ),
        SizedBox(height: 16),
        Text(
          'Data Tidak Ditemukan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Belum ada aktivitas yang sedang berjalan...',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
