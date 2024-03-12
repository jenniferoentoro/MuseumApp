import 'package:flutter/material.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/explore/explore_card_body.dart';
import 'package:museum_app/screens/explore/explore_card_image.dart';

class ExploreMuseumCard extends StatelessWidget {
  final Museum museum;
  final int index;
  final int countItem;
  const ExploreMuseumCard({
    Key? key,
    required this.museum,
    required this.index,
    required this.countItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: (index != countItem - 1)
          ? const EdgeInsets.only(left: kDefaultPadding)
          : const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: const Color(0xFFE8E8E8),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     offset: const Offset(5, 5),
        //     blurRadius: 5,
        //     color: kShadowColor,
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // gambar museum
          ExploreCardImage(museum: museum, size: size),

          // deskripsi museum
          ExploreCardBody(museum: museum)
        ],
      ),
    );
  }
}
