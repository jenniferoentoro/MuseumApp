import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/screens/detail/detail_museum.dart';
import 'package:museum_app/screens/search/search.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isFavorite = false;

  @override
  void initState() {
    getFavorites();
    getProfile();
    super.initState();
  }

  void updateList(int indexItem) {
    setState(() {
      print(indexItem);
      user_1.getFavoritMuseum().removeWhere((item) => item.id == indexItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          child: (user_1.getFavoritMuseum().isEmpty)
              ? Container(
                  // color: Colors.amber,
                  margin: const EdgeInsets.all(20),
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          'assets/images/browse.png',
                          height: size.height * 0.35,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Looks like you don't have any favorites yet!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        "Browse our museums to find your favorite ones.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFADA4A5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // browse button
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(
                                museums: popular,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF89B0AE),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF89B0AE).withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset: Offset.zero,
                              ),
                            ],
                          ),
                          child: const Text(
                            "Browse museums",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: user_1.getFavoritMuseum().length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMuseum(
                              museum: user_1.getFavoritMuseum()[index],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: (index == 0) ? 20 : 10,
                              right: 20,
                              bottom: (index ==
                                      user_1.getFavoritMuseum().length - 1)
                                  ? 20
                                  : 10,
                            ),
                            child: Container(
                              height: 275,
                              width: size.width,
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
                                //   image: AssetImage('assets/images/' +
                                //       user_1
                                //           .getFavoritMuseum()[index]
                                //           .getGambarUtama()),
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              child: Stack(
                                children: [
                                  ImageNetwork(
                                    image: user_1
                                        .getFavoritMuseum()[index]
                                        .getGambarUtama(),
                                    width: size.width,
                                    height: size.height * 0.5,
                                    fitAndroidIos: BoxFit.cover,
                                    fitWeb: BoxFitWeb.cover,
                                    onLoading: const CircularProgressIndicator(
                                      color: Color(0xFF89B0AE),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    onError: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          const Color(0xFF0D1B2A)
                                              .withOpacity(0.8),
                                          const Color(0xFF1B263B)
                                              .withOpacity(0.6),
                                          const Color(0xFF415A77)
                                              .withOpacity(0.4),
                                          const Color(0xFF778DA9)
                                              .withOpacity(0.2),
                                          const Color(0xFFE0E1DD)
                                              .withOpacity(0.1),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF808080)
                                              .withOpacity(0.25),
                                          offset: const Offset(
                                            3.0,
                                            3.0,
                                          ),
                                          blurRadius: 2.5,
                                          spreadRadius: 0.5,
                                        ), //BoxShadow
                                      ],
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: kDefaultPadding,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 10,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // nama museum
                                                Text(
                                                  user_1
                                                      .getFavoritMuseum()[index]
                                                      .getNama(),
                                                  style: const TextStyle(
                                                    color: Color(0xFFE0E1DD),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        "Cera Round Pro",
                                                  ),
                                                ),

                                                // kota museum
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xFF778DA9),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        user_1
                                                            .getFavoritMuseum()[
                                                                index]
                                                            .getAlamatKota(),
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFFE0E1DD),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              "Cera Round Pro",
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                // rating museum
                                                FittedBox(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5),
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFFF5FCFF)
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(12),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          user_1
                                                              .getFavoritMuseum()[
                                                                  index]
                                                              .getRating()
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF555B6E),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "Cera Round Pro 2",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // favorite button
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xFF808080)
                                                          .withOpacity(0.25),
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
                                                  icon: const Icon(
                                                      Icons.favorite),
                                                  color:
                                                      const Color(0xFFDA3E52),
                                                  iconSize: 30,
                                                  onPressed: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                          'Remove from favorite?',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        content: const Text(
                                                          'This museum will be remove from your favorite list.',
                                                          style: TextStyle(
                                                            height: 1.5,
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                              context,
                                                              'Cancel',
                                                            ),
                                                            child: const Text(
                                                              'Cancel',
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              updateList(
                                                                user_1
                                                                    .getFavoritMuseum()[
                                                                        index]
                                                                    .getId(),
                                                              ); // tambahkan news ke listFavorite
                                                              Navigator.pop(
                                                                context,
                                                                'OK',
                                                              );
                                                            },
                                                            child: const Text(
                                                              'OK',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),

                                              // chevron icon
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
