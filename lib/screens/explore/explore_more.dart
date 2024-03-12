import 'package:flutter/material.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/detail/detail_museum.dart';
import 'package:museum_app/screens/explore/explore_more_card.dart';

class ExploreMore extends StatefulWidget {
  final List<Museum> museums;
  final String sectionTitle;
  const ExploreMore(
      {Key? key, required this.museums, required this.sectionTitle})
      : super(key: key);

  @override
  State<ExploreMore> createState() => _ExploreMoreState();
}

class _ExploreMoreState extends State<ExploreMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text(widget.sectionTitle),
              backgroundColor: const Color(0xFF89B0AE),
            ),
          ],
          body: ListView.builder(
            itemCount: widget.museums.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMuseum(
                        museum: widget.museums[index],
                      ),
                    ),
                  );
                },
                child: ExploreMoreCard(
                  index: index,
                  length: widget.museums.length,
                  museum: widget.museums[index],
                ),
              );
            },
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.sectionTitle),
    //     backgroundColor: const Color(0xFF89B0AE),
    //   ),
    //   body: Container(
    //     child: ListView.builder(
    //       itemCount: widget.museums.length,
    //       physics: const BouncingScrollPhysics(),
    //       shrinkWrap: true,
    //       itemBuilder: (context, index) {
    //         return InkWell(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => DetailMuseum(
    //                   museum: widget.museums[index],
    //                 ),
    //               ),
    //             );
    //           },
    //           child: ExploreMoreCard(
    //             size: size,
    //             museum: widget.museums[index],
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
