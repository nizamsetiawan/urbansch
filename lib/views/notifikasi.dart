import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/widgets/button.dart';

class NotifikasiView extends StatefulWidget {
  @override
  _NotifikasiViewState createState() => _NotifikasiViewState();
}

class _NotifikasiViewState extends State<NotifikasiView> {
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    // Call the function to get notifications when the widget is initialized
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';
    print("Access Token: $token");

    try {
      final response = await http.get(
        Uri.parse('https://urbanscholaria.my.id/api/notifikasi'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        // Check if responseBody is not null and contains the 'data' key
        if (responseBody != null && responseBody.containsKey('data')) {
          final List<dynamic> notificationsData = responseBody['data'];

          setState(() {
            notifications = notificationsData
                .map<String>((data) => json.encode(data) ?? '')
                .toList();
          });
        } else {
          print("Invalid response body format: $responseBody");
        }
      } else {
        print("Error fetching notifications: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      print("Error fetching notifications: $error");
    }
  }

  String formatDateTime(String dateTimeString) {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateFormat.format(dateTime);
    } catch (e) {
      print("Error formatting date: $e");
      return '';
    }
  }

  void showNotificationDetail(
      String title, String subject, String content, String notificationId) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          color: appwhite,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: appbrand100,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: appbrand500,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: appneutral800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                subject,
                style: TextStyle(
                  color: appneutral500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Mark the notification as seen when the user taps "Kembali"
                  markNotificationAsSeen(notificationId);
                  Get.back();
                },
                child: ButtonWidgets(
                  label: "Kembali",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> markNotificationAsSeen(String notificationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('access_token') ?? '';

    try {
      final response = await http.put(
        Uri.parse(
            'https://urbanscholaria.my.id/api/notifikasi/$notificationId/mark-as-seen'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print("Notification marked as seen successfully");
      } else {
        print("Error marking notification as seen: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      print("Error marking notification as seen: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: Text("NOTIFIKASI"),
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = json.decode(notifications[index]);

          return GestureDetector(
            onTap: () {
              showNotificationDetail(
                notification['judul'] ?? '',
                notification['deskripsi'] ?? '',
                notification['created_at'] ?? '',
                notification['id']
                    .toString(), // Assuming 'id' is the field containing the notification ID
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appbrand100,
                          ),
                          child: const Icon(
                            Icons.notifications,
                            color: appbrand500,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['judul'] ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: appneutral800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          formatDateTime(notification['created_at'] ?? ''),
                          style: TextStyle(
                            color: appneutral500,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Divider(
                    thickness: 1,
                    color: appneutral500,
                  ),
                ),
                // Jarak antara Divider dan card notifikasi
              ],
            ),
          );
        },
      ),
    );
  }
}
