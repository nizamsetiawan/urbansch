// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:urbanscholaria_app/constant/colors.dart';
// import 'package:urbanscholaria_app/routes/routes.dart';

// class ListperizinanView extends StatelessWidget {
//   final listPerizinanController = Get.put(ListperizinanController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appbrand500,
//         title: const Text("INFORMASI PERIZINAN"),
//         centerTitle: true,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Get.offAllNamed(RouteNames.bottomNavigation);
//           },
//           child: const Icon(Icons.arrow_back_ios_new),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Stack(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                         height: 222,
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage("assets/images/Background.png"),
//                               fit: BoxFit.cover),
//                         ),
//                         child: Stack(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Nikmati Kemudahan\nPerizinan Sekolah\nSecara Digital',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15,
//                                         color: appwhite,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         buildRow(Icons.description_outlined,
//                                             "3 Perizinan", appwhite),
//                                         const SizedBox(height: 5),
//                                         buildRow(Icons.apartment,
//                                             "4 Kategori Sekolah", appwhite),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 // Spacing between text and image
//                                 Container(
//                                   margin: const EdgeInsets.only(top: 50),
//                                   width: 150,
//                                   height: 123,
//                                   child: Image.asset(
//                                       "assets/icons/iconstoplistperizinan.png"),
//                                 )
//                               ],
//                             ),
//                           ],

//                           //
//                         )),
//                   ],
//                 ),
//                 Container(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 250,
//                       left: 20,
//                       right: 20,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(
//                               'assets/icons/icontk.png',
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             const Text(
//                               "Perizinan Kanak-Kanak",
//                               style: TextStyle(
//                                   color: appneutral800,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         // ListView untuk menampilkan kartu
//                         Container(
//                           height: 160,
//                           child: Obx(
//                             () => ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: listPerizinanController.permits.length,
//                               itemBuilder: (context, index) {
//                                 if (listPerizinanController.permits[index]
//                                     is TKCardPerizinan) {
//                                   // Pastikan hanya kartu TK yang ditampilkan
//                                   return PermitCard(
//                                     permit:
//                                         listPerizinanController.permits[index],
//                                   );
//                                 } else {
//                                   return const SizedBox(); // Tampilkan widget kosong jika bukan kartu TK
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(top: 450, left: 20, right: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(
//                               'assets/icons/icontk.png',
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             const Text(
//                               "Perizinan  Sekolah Dasar",
//                               style: TextStyle(
//                                   color: appneutral800,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         // ListView untuk menampilkan kartu
//                         Container(
//                           height: 160,
//                           child: Obx(
//                             () => ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: listPerizinanController.permits.length,
//                               itemBuilder: (context, index) {
//                                 if (listPerizinanController.permits[index]
//                                     is SDCardPerizinan) {
//                                   // Pastikan hanya kartu SD yang ditampilkan
//                                   return PermitCard(
//                                     permit:
//                                         listPerizinanController.permits[index],
//                                   );
//                                 } else {
//                                   return const SizedBox(); // Tampilkan widget kosong jika bukan kartu SD
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(top: 850, left: 20, right: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(
//                               'assets/icons/icontk.png',
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             const Text(
//                               "Perizinan Sekolah Menengah Atas",
//                               style: TextStyle(
//                                   color: appneutral800,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         // ListView untuk menampilkan kartu
//                         Container(
//                           height: 160,
//                           child: Obx(
//                             () => ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: listPerizinanController.permits.length,
//                               itemBuilder: (context, index) {
//                                 if (listPerizinanController.permits[index]
//                                     is SMACardPerizinan) {
//                                   // Pastikan hanya kartu SMP yang ditampilkan
//                                   return PermitCard(
//                                     permit:
//                                         listPerizinanController.permits[index],
//                                   );
//                                 } else {
//                                   return const SizedBox(); // Tampilkan widget kosong jika bukan kartu SMP
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(top: 650, left: 20, right: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(
//                               'assets/icons/icontk.png',
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             const Text(
//                               "Perizinan Sekolah Menengah Pertama",
//                               style: TextStyle(
//                                   color: appneutral800,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         // ListView untuk menampilkan kartu
//                         Container(
//                           height: 160,
//                           child: Obx(
//                             () => ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: listPerizinanController.permits.length,
//                               itemBuilder: (context, index) {
//                                 if (listPerizinanController.permits[index]
//                                     is SMPCardPerizinan) {
//                                   // Pastikan hanya kartu SMP yang ditampilkan
//                                   return PermitCard(
//                                     permit:
//                                         listPerizinanController.permits[index],
//                                   );
//                                 } else {
//                                   return const SizedBox(); // Tampilkan widget kosong jika bukan kartu SMP
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// //widget icon kecil jumlah
// Widget buildRow(IconData icon, String text, Color color) {
//   return Row(
//     children: [
//       Icon(icon, color: color),
//       const SizedBox(width: 5),
//       Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//         ),
//       ),
//     ],
//   );
// }
