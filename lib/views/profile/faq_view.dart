import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/profile_c.dart';
import 'package:urbanscholaria_app/models/profile_m.dart';

class FAQView extends StatelessWidget {
  final FAQController _faqController = Get.put(FAQController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("FAQs"),
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Hi Scholaria, berikut beberapa informasi yang mungkin kamu butuhkan sebelum FAQ:',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 20.0),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: _faqController.faqs.length,
                itemBuilder: (context, index) {
                  FAQModel faq = _faqController.faqs[index];
                  return ExpansionTile(
                    title: Text(
                      faq.question,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: appbrand800),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          faq.answer,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: appneutral500,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
