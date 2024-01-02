import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:http/http.dart' as http;

class OperatorFeedbackView extends StatefulWidget {
  @override
  _OperatorFeedbackViewState createState() => _OperatorFeedbackViewState();
}

class _OperatorFeedbackViewState extends State<OperatorFeedbackView> {
  List<Map<String, dynamic>> feedbackData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final List<Map<String, dynamic>> fetchedData = await getFeedbackToApi();
    setState(() {
      feedbackData = fetchedData;
    });
  }

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
        itemCount: feedbackData.length,
        itemBuilder: (context, index) {
          return buildFeedbackCard(feedbackData[index]);
        },
      ),
    );
  }

  Widget buildFeedbackCard(Map<String, dynamic> feedback) {
    String formattedDate = DateFormat('dd MMMM yyyy')
        .format(DateTime.parse(feedback['created_at']));

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"${feedback['isi']}"',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'ID: ${feedback['id']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Document: ${feedback['nama_surat']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${feedback['surat']['status']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              feedback['nama_lengkap'],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              feedback['nomor_identitas'],
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              formattedDate,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getFeedbackToApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    final apiUrl = '${BASE_API}api/feedback-pemohon';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<Map<String, dynamic>> feedbackList =
            List.from(responseData['data']);
        return feedbackList;
      } else {
        print('Failed to fetch feedback. Status code: ${response.statusCode}');
        print('Error Response: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Error fetching feedback: $error');
      return [];
    }
  }
}
