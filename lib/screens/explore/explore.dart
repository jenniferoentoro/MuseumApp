import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/explore/explore_section.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExploreSection(
              museums: recent,
              sectionTitle: "City Highlight",
              sectionDescription: "Museum Terpopuler di Setiap Kota",
            ),
            ExploreSection(
              museums: rating,
              sectionTitle: "Historical Museum",
              sectionDescription: "Lihat Museum-museum Sejarah di Indonesia",
            ),
            ExploreSection(
              museums: popular,
              sectionTitle: "Archaelogical Museum",
              sectionDescription:
                  "Berisikan Peninggalan Sejarah Kerajaan di Indonesia",
            ),
          ],
        ),
      ),
    );
  }
}
