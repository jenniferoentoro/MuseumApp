import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/detail/detail_museum.dart';
import 'package:museum_app/screens/home/museum_card.dart';

class TabBarViewSection extends StatelessWidget {
  const TabBarViewSection({
    Key? key,
    required TabController tabController,
    required this.popular,
    required this.recent,
    required this.rating,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  final List<Museum> popular;
  final List<Museum> recent;
  final List<Museum> rating;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      // height: (size.height * 0.575 + kDefaultPadding) * 3 + kDefaultPadding,
      height: size.height * 0.575,
      margin: const EdgeInsets.only(bottom: 25),
      child: TabBarView(
        controller: _tabController,
        children: [
          // popular section
          _customListView(popular),

          // recent section
          _customListView(recent),

          // rating section
          _customListView(rating),
        ],
      ),
    );
  }

  Widget _customListView(List<Museum> data) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      // physics: const NeverScrollableScrollPhysics(),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMuseum(
                  museum: data[index],
                ),
              ),
            );
          },
          child: MuseumCard(
            index: index,
            length: data.length,
            museum: data[index],
          ),
        );
      },
    );
  }
}
