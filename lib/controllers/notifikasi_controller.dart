// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:urbanscholaria_app/constant/colors.dart';

// import 'package:urbanscholaria_app/models/notifikasi_m.dart';

// class NotificationController extends GetxController {
//   var notifications = <NotificationModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchNotifications();
//   }

//   void fetchNotifications() async {
//     // Di sini kamu akan memanggil API untuk mendapatkan notifikasi
//     // Untuk contoh sementara, kita buat data dummy
//     List<NotificationModel> fetchedNotifications = [
//       NotificationModel(
//         title: 'Pengajuan Perizinan Diterima',
//         date: '13 Nov 2023 | 13:54',
//         subject: 'Subject: Pengajuan Perizinan Diterima',
//         content: _buildNotificationContent(
//             'Hi Scholar,\n\n\nPesan ini merupakan pesan otomatis dari sistem US. Terima kasih atas partisipasi Anda mengajukan permohonan perizinan pada aplikasi Urban Scholaria yaitu: Perizinan Pembangunan Sekolah Dasar.'
//             "Saat ini Anda telah menyelesaikan proses pendaftaran pengajuan dan telah kami terima, untuk proses dan tahapan selanjutnya akan diinfokan melalui email resmi dan bisa lacak melalui fitur aplikasi Urban Scholaria. \n\nSalam,\n\n\nAdmin Urban Scholaria"),
//       ),
//       NotificationModel(
//         title: 'Pengajuan Perizinan Diterima',
//         date: '13 Nov 2023 | 13:54',
//         subject: 'Pengajuan Perizinan Diterima',
//         content: _buildNotificationContent(''),
//       ),
//       NotificationModel(
//         title: 'Penjadwalan Survey Lokasi',
//         date: '13 Nov 2023 | 13:54',
//         subject: 'Penjadwalan Survey Lokasi...',
//         content: _buildNotificationContent(''),
//       ),
//       NotificationModel(
//         title: 'Pemberitahuan Layanan',
//         date: '13 Nov 2023 | 13:54',
//         subject: 'Pemberitahuan Layanan',
//         content: _buildNotificationContent(''),
//       ),
//       NotificationModel(
//         title: 'Status Permohonan Perizinan',
//         date: '13 Nov 2023 | 13:54',
//         subject: 'Status Permohonan Perizinan',
//         content: _buildNotificationContent(''),
//       ),
//       NotificationModel(
//         title: 'Pengajuan Perizinan Pembangunan SD',
//         date: '13 Nov 2023 | 13:54',
//         subject: 'Pengajuan Perizinan Pembangunan...',
//         content: _buildNotificationContent(''),
//       ),
//       // Tambah notifikasi lainnya
//     ];

//     notifications.assignAll(fetchedNotifications);
//   }

//   Widget _buildNotificationContent(String text) {
//     // Fungsi untuk membuat konten notifikasi
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: appneutral500,
//           fontSize: 10,
//         ),
//       ),
//     );
//   }
// }
