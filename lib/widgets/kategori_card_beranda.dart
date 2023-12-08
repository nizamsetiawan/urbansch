import 'package:flutter/material.dart';
import 'package:urbanscholaria_app/constant/colors.dart';

class KategoriPerizinan extends StatelessWidget {
  final String? iconPath;
  final String? label;

  KategoriPerizinan({
    this.iconPath,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: appbrand50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('${iconPath}'),
          SizedBox(
            height: 8,
          ),
          Text(
            "${label}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
