import 'package:flutter/material.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class CustomTextFieldContainer extends StatelessWidget {
  final String title;
  final bool? enabled;

  final TextEditingController controller;

  const CustomTextFieldContainer({
    Key? key,
    required this.title,
    required this.controller,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: appneutral500),
        ),
        const SizedBox(
          height: 3,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: appneutral400),
            color: enabled != null && enabled == false
                ? appneutral200 // Warna abu-abu jika dinonaktifkan
                : null, // Biarkan kosong jika diaktifkan
          ),
          child: TextField(
            controller: controller,
            autocorrect: false,
            enabled: enabled,
            style: TextStyle(fontSize: 12, color: appneutral900),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
              hintText: "Masukkan ($title)",
            ),
          ),
        ),
      ],
    );
  }
}
