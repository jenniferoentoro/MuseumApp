import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:museum_app/api_service.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/user.dart';

class MuseumCard extends StatelessWidget {
  final int index;
  final int length;
  final Museum museum;

  const MuseumCard({
    Key? key,
    required this.index,
    required this.length,
    required this.museum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: (index != length - 1)
              ? const EdgeInsets.only(left: kDefaultPadding)
              : const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
          // padding: (index != length - 1)
          //     ? const EdgeInsets.only(
          //         left: kDefaultPadding,
          //         top: kDefaultPadding,
          //         right: kDefaultPadding)
          //     : const EdgeInsets.all(kDefaultPadding),
          child: Container(
            height: size.height * 0.55,
            // width: size.width * 0.85,
            width: size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 5),
                  blurRadius: 5,
                  color: kShadowColor,
                ),
              ],
              // image: DecorationImage(
              //   image: AssetImage('assets/images/' + museum.getGambarUtama()),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Stack(
              children: [
                ImageNetwork(
                  image: museum.getGambarUtama(),
                  width: size.width,
                  height: size.height * 0.5,
                  fitAndroidIos: BoxFit.cover,
                  fitWeb: BoxFitWeb.cover,
                  borderRadius: BorderRadius.circular(20),
                  onLoading: const CircularProgressIndicator(
                    color: Color(0xFF89B0AE),
                  ),
                  onError: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                CardBody(
                  museum: museum,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({
    Key? key,
    required this.museum,
  }) : super(key: key);

  final Museum museum;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            const Color(0xFF0D1B2A).withOpacity(0.8),
            const Color(0xFF1B263B).withOpacity(0.6),
            const Color(0xFF415A77).withOpacity(0.4),
            const Color(0xFF778DA9).withOpacity(0.2),
            const Color(0xFFE0E1DD).withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF808080).withOpacity(0.25),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 2.5,
            spreadRadius: 0.5,
          ), //BoxShadow
        ],
      ),
      child: CardDetail(
        museum: museum,
      ),
    );
  }
}

class CardDetail extends StatefulWidget {
  const CardDetail({
    Key? key,
    required this.museum,
  }) : super(key: key);

  final Museum museum;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  void initState() {
    getFavorites();
    getProfile();
    super.initState();
  }

  bool isFavorite = false;

  void updateButton() {
    setState(() {
      if (isFavorite) {
        isFavorite = false;
        ApiService().deleteFavorite(widget.museum.getId());
        user_1
            .getFavoritMuseum()
            .removeWhere((item) => item.id == widget.museum.getId());
        // print(user_1.getFavoritMuseum().toString());
        // print("Is click false");
        // print(museum_1.getId().toString());
        // print(user_1.getFavoritMuseum().length.toString());
        // print("Cek 2 instances: " +
        //     (museum_1.getId() == user_1.getFavoritMuseum()[1].getId())
        //         .toString());
        // print("Cek 2 instances: " +
        //     identical(museum_1, user_1.getFavoritMuseum()[1]).toString());
      } else {
        isFavorite = true;
        ApiService().storeFavorite(widget.museum.getId());

        user_1.getFavoritMuseum().add(widget.museum);
        // print(user_1.getFavoritMuseum().toString());
        // print("Is click true");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // cek apakah museum ini ada di favorite-nya user
    for (int i = 0; i < user_1.getFavoritMuseum().length; i++) {
      if (identical(
          widget.museum.getId(), user_1.getFavoritMuseum()[i].getId())) {
        isFavorite = true;
        break;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: kDefaultPadding,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // nama museum
                Text(
                  widget.museum.getNama(),
                  style: const TextStyle(
                    color: Color(0xFFE0E1DD),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cera Round Pro",
                  ),
                ),

                // kota museum
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF778DA9),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.museum.getAlamatKota(),
                        style: const TextStyle(
                          color: Color(0xFFE0E1DD),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Cera Round Pro",
                        ),
                      )
                    ],
                  ),
                ),

                // rating museum
                FittedBox(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FCFF).withOpacity(0.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.museum.getRating().toString(),
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
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // favorite button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF808080).withOpacity(0.25),
                      offset: const Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius: 2.5,
                      spreadRadius: 0.5,
                    ), //BoxShadow
                  ],
                ),
                child: IconButton(
                  icon: (isFavorite)
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border_rounded),
                  color: const Color(0xFFDA3E52),
                  iconSize: 30,
                  onPressed: () {
                    updateButton();
                  },
                ),
              ),

              // chevron icon
              Container(
                alignment: Alignment.bottomCenter,
                child: const Icon(
                  Icons.chevron_right_sharp,
                  color: Color(0xFFE0E1DD),
                  size: 35,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class CardDetail extends StatelessWidget {
//   const CardDetail({
//     Key? key,
//     required this.name,
//     required this.city,
//     required this.rating,
//   }) : super(key: key);

//   final String name;
//   final String city;
//   final double rating;

//   @override
//   Widget build(BuildContext context) {
//     bool is_click = false;

//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 15,
//         vertical: kDefaultPadding,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 10,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // nama museum
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     color: Color(0xFFE0E1DD),
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: "Cera Round Pro",
//                   ),
//                 ),

//                 // kota museum
//                 Container(
//                   padding: const EdgeInsets.only(top: 5),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         color: Color(0xFF778DA9),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         city,
//                         style: const TextStyle(
//                           color: Color(0xFFE0E1DD),
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           fontFamily: "Cera Round Pro",
//                         ),
//                       )
//                     ],
//                   ),
//                 ),

//                 // rating museum
//                 FittedBox(
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF5FCFF).withOpacity(0.5),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           rating.toString(),
//                           style: const TextStyle(
//                             color: Color(0xFF555B6E),
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: "Cera Round Pro 2",
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         const Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                           size: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // favorite button
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(50.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF808080).withOpacity(0.25),
//                       offset: const Offset(
//                         3.0,
//                         3.0,
//                       ),
//                       blurRadius: 2.5,
//                       spreadRadius: 0.5,
//                     ), //BoxShadow
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: (is_click)
//                       ? const Icon(Icons.favorite_border_rounded)
//                       : const Icon(Icons.favorite),
//                   color: const Color(0xFFDA3E52),
//                   iconSize: 30,
//                   onPressed: () {
//                     if (is_click == true) {
//                       // remove from favorite
//                       is_click = false;
//                       print("Is click false");
//                     } else {
//                       // add to favorite
//                       is_click = true;
//                       print("Is click true");
//                     }
//                   },
//                 ),
//               ),

//               // chevron icon
//               Container(
//                 alignment: Alignment.bottomCenter,
//                 child: const Icon(
//                   Icons.chevron_right_sharp,
//                   color: Color(0xFFE0E1DD),
//                   size: 35,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
