import 'package:flutter/material.dart';

import 'package:urbanscholaria_app/constant/colors.dart';

class RiwayatView extends StatefulWidget {
  // final PerizinanController riwayatController = Get.put(PerizinanController());

  @override
  _RiwayatViewState createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // widget.riwayatController.groupPengajuanByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("RIWAYAT"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildTab('Proses', 0, Icons.access_time),
                buildTab('Verifikasi', 1, Icons.verified),
                buildTab('Survey', 2, Icons.poll),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  buildProsesScreen(),
                  buildVerifikasiScreen(),
                  buildSurveyScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String title, int index, IconData icon) {
    return InkWell(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentIndex == index ? appbrand800 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _currentIndex == index ? appbrand800 : appneutral500,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _currentIndex == index ? appbrand800 : appneutral500,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProsesScreen() {
    return Text("data");
    // widget.riwayatController.groupPengajuanByStatus();
    // return Obx(() {
    //   final prosesList = widget.riwayatController.prosesList;
    //   return ListView.builder(
    //     itemCount: prosesList.length,
    //     itemBuilder: (context, index) {
    //       final pengajuan = prosesList[index];
    //       return PerizinanCardWidget(
    //         pengajuan: pengajuan,
    //         onTap: () {
    //           Get.toNamed(
    //             RouteNames.riwayatperizinan,
    //             arguments: pengajuan.idPengajuan,
    //           );
    //         },
    //       );
    //     },
    //   );
    // });
  }

  Widget buildVerifikasiScreen() {
    return Text("data");
    // widget.riwayatController.groupPengajuanByStatus();
    // return Obx(() {
    //   final verifikasiList = widget.riwayatController.verifikasiList;
    //   return ListView.builder(
    //     itemCount: verifikasiList.length,
    //     itemBuilder: (context, index) {
    //       final pengajuan = verifikasiList[index];
    //       return PerizinanCardWidget(
    //         pengajuan: pengajuan,
    //         onTap: () {
    //           Get.toNamed(
    //             RouteNames.riwayatperizinan,
    //             arguments: pengajuan.idPengajuan,
    //           );
    //         },
    //       );
    //     },
    //   );
    // });
  }

  Widget buildSurveyScreen() {
    return Text("data");
    // widget.riwayatController.groupPengajuanByStatus();
    // return Obx(() {
    //   final surveyList = widget.riwayatController.surveyList;
    //   return ListView.builder(
    //     itemCount: surveyList.length,
    //     itemBuilder: (context, index) {
    //       final pengajuan = surveyList[index];
    //       return PerizinanCardWidget(
    //         pengajuan: pengajuan,
    //         onTap: () {
    //           Get.toNamed(
    //             RouteNames.riwayatperizinan,
    //             arguments: pengajuan.idPengajuan,
    //           );
    //         },
    //       );
    //     },
    //   );
    // });
  }
}
