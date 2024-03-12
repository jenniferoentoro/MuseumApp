import 'package:flutter/material.dart';
import 'package:museum_app/constants.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/screens/detail/detail_museum.dart';
import 'package:museum_app/screens/favorites/favorite_card.dart';
import 'package:museum_app/screens/search/search.dart';

class FavoriteTempPage extends StatefulWidget {
  const FavoriteTempPage({Key? key}) : super(key: key);

  @override
  State<FavoriteTempPage> createState() => _FavoriteTempPageState();
}

class _FavoriteTempPageState extends State<FavoriteTempPage> {
  @override
  void initState() {
    getFavorites();
    getProfile();
    super.initState();
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
                      child: FavoriteCard(
                        index: index,
                        length: user_1.getFavoritMuseum().length,
                        museum: user_1.getFavoritMuseum()[index],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
