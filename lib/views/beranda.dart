import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/beranda_c.dart';
import 'package:urbanscholaria_app/controllers/profile_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';

import 'package:urbanscholaria_app/widgets/aktivitas_card_beranda.dart';
import 'package:urbanscholaria_app/widgets/kategori_card_beranda.dart';

class BerandaView extends StatelessWidget {
  final BerandaController controller = Get.put(BerandaController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  BerandaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 250, child: _head()),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 32, left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aktivitas",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: appneutral500),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardActivity(
                          statuspengajuan: 'Diajukan',
                          iconPath: 'assets/icons/diajukan.png',
                          jumlahpengajuan: '1',
                        ),
                        CardActivity(
                          jumlahpengajuan: '1',
                          iconPath: 'assets/icons/diterima.png',
                          statuspengajuan: 'Diterima',
                        ),
                        CardActivity(
                          jumlahpengajuan: '1',
                          iconPath: 'assets/icons/ditolak.png',
                          statuspengajuan: 'Ditolak',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Lacak Permohonan Anda",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    // onTap: () => Get.toNamed(RouteNames.search),
                    child: Container(
                      width: 240,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: appneutral400)),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("ID Pengajuan"), Icon(Icons.search)],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kategori Perizinan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => controller.handleCategoryTap('TK'),
                                child: KategoriPerizinan(
                                  label: 'Perizinan TK',
                                  iconPath: 'assets/icons/tk.png',
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller.handleCategoryTap('SD'),
                                child: KategoriPerizinan(
                                  label: 'Perizinan SD',
                                  iconPath: 'assets/icons/sd.png',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    controller.handleCategoryTap('SMP'),
                                child: KategoriPerizinan(
                                  label: 'Perizinan SMP',
                                  iconPath: 'assets/icons/smp.png',
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    controller.handleCategoryTap('SMA'),
                                child: KategoriPerizinan(
                                  label: 'Perizinan SMA',
                                  iconPath: 'assets/icons/sma.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

//widget head ajukan perizinan
  Widget _head() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 218,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/topberanda.png"),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 23,
                    left: 300,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(RouteNames.notifikasi),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: appbrand100,
                            child: const Icon(
                              Icons.notifications,
                              color: appbrand500,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 36),
                    child: Text(
                      "Hai ${editProfileController.namaLengkapController.text ?? ''}!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 120,
          left: 25,
          child: Container(
            height: 128,
            width: 328,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: appbrand500,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 25,
                  spreadRadius: -5,
                  offset: const Offset(0, 9), // mengubah posisi bayangan
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nikmati Kemudahan\nPerizinan Sekolah",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: appwhite),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/beranda.icon.png"),
                            fit: BoxFit.cover),
                      ),
                      width: 100,
                      height: 100,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
