import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class ButtonWidgets extends StatelessWidget {
  final String? label;
  const ButtonWidgets({
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: Get.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: appbrand500,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('${label}',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: appwhite)),
    );
  }
}
