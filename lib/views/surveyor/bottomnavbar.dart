import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/rolesnav/bottomnavbar_c.dart';

class SurveyorBottomView extends StatelessWidget {
  final controller = Get.put(SurveyorBottomnavigationController());

  // Judul untuk setiap item di bottom navigation
  final List<String> judul = [
    'Dashboard',
    'Perizinan',
    'Verifikasi',
    'Feedback',
    'Pengaturan'
  ];

  // Ikon aktif dan nonaktif untuk setiap item
  final List<IconData> activeIcons = [
    Icons.dashboard,
    Icons.assignment,
    Icons.verified,
    Icons.feedback,
    Icons.settings,
  ];

  final List<IconData> inactiveIcons = [
    Icons.dashboard_outlined,
    Icons.assignment_outlined,
    Icons.verified_outlined,
    Icons.feedback_outlined,
    Icons.settings_outlined,
  ];

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
          items: List.generate(
            judul.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(
                controller.CurrentIndex.value == index
                    ? activeIcons[index]
                    : inactiveIcons[index],
                size: 24,
              ),
              label: judul[index],
            ),
          ),
        ),
      ),
    );
  }
}
