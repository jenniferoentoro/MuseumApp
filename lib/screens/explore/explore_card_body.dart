import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';

class ExploreCardBody extends StatelessWidget {
  const ExploreCardBody({
    Key? key,
    required this.museum,
  }) : super(key: key);

  final Museum museum;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // nama museum
            Text(
              museum.getNama(),
              style: const TextStyle(
                fontFamily: "Cera Round Pro 2",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // lokasi museum
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF778DA9),
                  size: 25,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    museum.getAlamatLengkap(),
                    style: const TextStyle(
                      color: Color(0xFFBEBEBE),
                      height: 1.5,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Cera Round Pro 2",
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
