import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/detail/detail_museum.dart';
import 'package:museum_app/screens/explore/explore_card.dart';
import 'package:museum_app/screens/explore/explore_more.dart';

class ExploreSection extends StatelessWidget {
  final List<Museum> museums;
  final String sectionTitle;
  final String sectionDescription;

  const ExploreSection({
    Key? key,
    required this.museums,
    required this.sectionTitle,
    required this.sectionDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // section title
        SectionHeading(
          museums: museums,
          sectionTitle: sectionTitle,
          sectionDescription: sectionDescription,
        ),

        // list museums
        SectionBody(museums: museums),
      ],
    );
  }
}

class SectionBody extends StatelessWidget {
  const SectionBody({
    Key? key,
    required this.museums,
  }) : super(key: key);

  final List<Museum> museums;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: (museums.length >= 5) ? 5 : museums.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMuseum(
                    museum: museums[index],
                  ),
                ),
              );
            },
            child: ExploreMuseumCard(
              museum: museums[index],
              index: index,
              countItem: (museums.length >= 5) ? 5 : museums.length,
            ),
          );
        },
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    Key? key,
    required this.museums,
    required this.sectionTitle,
    required this.sectionDescription,
  }) : super(key: key);

  final List<Museum> museums;
  final String sectionTitle;
  final String sectionDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        top: 20,
        right: 20,
        bottom: 10,
      ),
      child: Row(
        children: [
          // section title and description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionTitle,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 5,
                  width: 100,
                  color: const Color(0xFFBEE3DB),
                ),

                const SizedBox(height: 5),

                // section description
                Text(
                  sectionDescription,
                  style: const TextStyle(
                    color: Color(0xFFBEBEBE),
                    fontFamily: "Cera Round Pro 2",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // button explore more
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExploreMore(
                    museums: museums,
                    sectionTitle: sectionTitle,
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF89B0AE),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: const Text(
              "More",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
