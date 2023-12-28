import 'package:flutter/material.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class OperatorFeedbackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("FEEDBACK"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5, // Ganti dengan jumlah feedback yang ingin ditampilkan
        itemBuilder: (context, index) {
          return buildFeedbackCard();
        },
      ),
    );
  }

  Widget buildFeedbackCard() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"Perizinannya cepat dan efektif, sangat bagus."',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Regi Muhammar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1234567890123456',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              '23 November 2023',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
