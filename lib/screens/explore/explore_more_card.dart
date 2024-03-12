import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/screens/explore/explore_card_body.dart';

class ExploreMoreCard extends StatelessWidget {
  const ExploreMoreCard({
    Key? key,
    required this.index,
    required this.length,
    required this.museum,
  }) : super(key: key);

  final int index;
  final int length;
  final Museum museum;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: 20,
        top: (index == 0) ? 20 : 10,
        right: 20,
        bottom: (index == length - 1) ? 20 : 10,
      ),
      width: size.width,
      height: size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: const Color(0xFFE8E8E8),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, 5),
            blurRadius: 5,
            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // card heading
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                // image museum
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: ImageNetwork(
                    image: museum.getGambarUtama(),
                    width: size.width,
                    height: 225,
                    fitAndroidIos: BoxFit.cover,
                    fitWeb: BoxFitWeb.cover,
                    onLoading: const CircularProgressIndicator(
                      color: Color(0xFF89B0AE),
                    ),
                    onError: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  //     Image.asset(
                  //   'assets/images/' + museum.getGambarUtama(),
                  //   width: size.width,
                  //   height: 225,
                  //   fit: BoxFit.cover,
                  // ),
                ),

                // rating museum
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFBEE3DB).withOpacity(0.75),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                museum.getRating().toString(),
                                style: const TextStyle(
                                  color: Color(0xFF555B6E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Cera Round Pro 2",
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // card body
          ExploreCardBody(museum: museum)
        ],
      ),
    );
  }
}
