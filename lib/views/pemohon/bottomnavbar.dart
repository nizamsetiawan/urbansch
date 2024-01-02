import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/bottomnavbar_c.dart';

class BottomnavigationView extends StatelessWidget {
  final controller = Get.put(BottomnavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => SafeArea(
            child: controller.screens[controller.CurrentIndex.value],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: appbrand50,
            selectedItemColor: appneutral500,
            selectedLabelStyle: const TextStyle(fontSize: 12),
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => controller.SetIndex(index),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: controller.CurrentIndex.value == 0
                          ? appbrand100
                          : appbrand50,
                      image: DecorationImage(
                          image: AssetImage(controller.CurrentIndex.value == 0
                              ? 'assets/icons/home_active.png'
                              : 'assets/icons/home.png'))),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: controller.CurrentIndex.value == 1
                          ? appbrand100
                          : appbrand50,
                      image: DecorationImage(
                          image: AssetImage(controller.CurrentIndex.value == 1
                              ? 'assets/icons/riwayat_active.png'
                              : 'assets/icons/riwayat.png'))),
                ),
                label: 'Riwayat',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: controller.CurrentIndex.value == 2
                          ? appbrand100
                          : appbrand50,
                      image: DecorationImage(
                          image: AssetImage(controller.CurrentIndex.value == 2
                              ? 'assets/icons/scan_active.png'
                              : 'assets/icons/scan.png'))),
                ),
                label: 'Pindai',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: controller.CurrentIndex.value == 3
                          ? appbrand100
                          : appbrand50,
                      image: DecorationImage(
                          image: AssetImage(controller.CurrentIndex.value == 3
                              ? 'assets/icons/chat_active.png'
                              : 'assets/icons/chat.png'))),
                ),
                label: 'Obrolan',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: controller.CurrentIndex.value == 4
                          ? appbrand100
                          : appbrand50,
                      image: DecorationImage(
                          image: AssetImage(controller.CurrentIndex.value == 4
                              ? 'assets/icons/pengaturan_active.png'
                              : 'assets/icons/pengaturan.png'))),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }
}
