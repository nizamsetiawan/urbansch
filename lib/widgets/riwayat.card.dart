// import 'package:flutter/material.dart';

// class CustomCard extends StatelessWidget {
//   final Map<String, dynamic>? data;

//   const CustomCard({Key? key, this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (data == null) {
//       return SizedBox.shrink();
//     }

//     final suratJenis = data!['surat_jenis'] as Map<String, dynamic>?;

//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               suratJenis?['nama'] ?? 'Nama Not Available',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '${data!['created_at'] ?? 'Date Not Available'}',
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '${data!['nama'] ?? 'Nama Not Available'}',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '${data!['alamat_lokasi'] ?? 'Alamat Not Available'}',
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             Text(
//               'ID Pengajuan: ${data!['id'] ?? 'ID Not Available'}',
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Status: ${data!['status'] ?? 'Status Not Available'}',
//               style: TextStyle(
//                 color: data!['status'] == 'Pengajuan Ditolak'
//                     ? Colors.red
//                     : Colors.orange,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
