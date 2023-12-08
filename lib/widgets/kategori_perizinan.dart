import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/kategoriperizinan/TK/perizinantk_c.dart';
import 'package:urbanscholaria_app/widgets/jenis_perizinan_card.dart';

class PerizinanView extends StatelessWidget {
  final TKPerizinanController tkPerizinanController =
      Get.put(TKPerizinanController());
  final String title;
  final String backgroundImage;
  final List<dynamic> permits;

  PerizinanView({
    required this.title,
    required this.backgroundImage,
    required this.permits,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: Text("INFORMASI PERIZINAN"),
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: appwhite,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 122,
                              height: 122,
                              child: Image.asset(backgroundImage),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 150,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Perizinan",
                        style: TextStyle(
                          color: appneutral800,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 600,
                        child: Obx(
                          () {
                            print(
                                'Permits Length: ${tkPerizinanController.permitstk.length}'); // Log permits length
                            return ListView.builder(
                              itemCount: tkPerizinanController.permitstk.length,
                              itemBuilder: (context, index) {
                                return PermitCard(
                                  permit:
                                      tkPerizinanController.permitstk[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
