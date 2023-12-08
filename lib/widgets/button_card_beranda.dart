import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ButtonWidgetsCard extends StatelessWidget {
  final String? label;
  const ButtonWidgetsCard({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 136,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appbrand500,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('${label}',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 12, color: appwhite)),
    );
  }
}
