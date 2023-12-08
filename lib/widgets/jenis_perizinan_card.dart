import 'package:flutter/material.dart';
import 'package:urbanscholaria_app/models/kategori_m.dart';

class PermitCard extends StatelessWidget {
  final TKCardPerizinan permit; // Use TKCardPerizinan instead of CardPerizinan

  PermitCard({required this.permit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: permit.onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        height: 160,
        width: 256,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    permit.bannerimage, // Use bannerimage from TKCardPerizinan
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        permit.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder, size: 8),
                          SizedBox(width: 8.0),
                          Text(
                            permit.requirements,
                            style: TextStyle(fontSize: 8),
                          ),
                          SizedBox(width: 16.0),
                          Icon(Icons.folder, size: 8),
                          SizedBox(width: 8.0),
                          Text(
                            permit.processingTime,
                            style: TextStyle(fontSize: 8),
                          ),
                        ],
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
