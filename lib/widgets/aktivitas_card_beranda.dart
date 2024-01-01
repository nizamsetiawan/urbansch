// import 'package:flutter/material.dart';
// import 'package:urbanscholaria_app/constant/colors.dart';

// class CardActivity extends StatelessWidget {
//   final String? statuspengajuan;
//   final int? jumlahPengajuan; // Tipe data diubah menjadi int
//   final String? iconPath;

//   const CardActivity({
//     this.statuspengajuan,
//     this.jumlahPengajuan,
//     this.iconPath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Color jumlahPengajuanColor = Colors.black;

//     // Set warna berdasarkan jenis status
//     if (statuspengajuan == 'Diajukan') {
//       jumlahPengajuanColor = Colors.orange;
//     } else if (statuspengajuan == 'Ditolak') {
//       jumlahPengajuanColor = Colors.red;
//     } else if (statuspengajuan == 'Diterima') {
//       jumlahPengajuanColor = Colors.green;
//     }

//     return Container(
//       width: 85,
//       height: 85,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: appneutral300),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('${iconPath}'),
//               SizedBox(width: 5),
//               Text(
//                 "${statuspengajuan}",
//                 style: TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   color: appbrand800,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5),
//           Text(
//             "${jumlahPengajuan}",
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: jumlahPengajuanColor,
//             ),
//           ),
//           Text(
//             "Pengajuan",
//             style: TextStyle(
//               fontSize: 10,
//               color: appbrand800,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
