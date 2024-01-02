import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urbanscholaria_app/constant/base_api.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class UserActivationView extends StatefulWidget {
  final int userId;

  UserActivationView({required this.userId});

  @override
  _UserActivationViewState createState() => _UserActivationViewState();
}

class _UserActivationViewState extends State<UserActivationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: Text("Aktivasi Akun"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildActionButton("Aktivasi Akun", () {
              activateAccount(widget.userId);
            }),
            buildActionButton("Tolak Aktivasi Akun", () {
              rejectActivation(widget.userId);
            }),
            buildActionButton("Detail Pengguna", () {
              getUserDetail(widget.userId);
            }),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
        style: ElevatedButton.styleFrom(
          primary: appbrand500,
        ),
      ),
    );
  }

  Future<void> activateAccount(int userId) async {
    final apiUrl = '$BASE_API/api/aktivasi-akun/$userId';
    await sendActionRequest(apiUrl);
  }

  Future<void> rejectActivation(int userId) async {
    final apiUrl = '$BASE_API/api/tolak-aktivasi-akun/$userId';
    await sendActionRequest(apiUrl);
  }

  Future<void> getUserDetail(int userId) async {
    final apiUrl = '$BASE_API/api/user/$userId';
    await sendActionRequest(apiUrl);
  }

  Future<void> sendActionRequest(String apiUrl) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('access_token') ?? '';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Operasi berhasil dilakukan.'),
            backgroundColor: appdone500,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Gagal melakukan operasi. Kode status: ${response.statusCode}'),
            backgroundColor: appdanger500,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Silakan coba lagi.'),
          backgroundColor: appdanger500,
        ),
      );
    }
  }
}
