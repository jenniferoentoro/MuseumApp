import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:museum_app/api_service.dart';
import 'package:readmore/readmore.dart';
import 'package:museum_app/models/comment.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/screens/detail/detail_view_museum.dart';
import 'package:museum_app/widgets/comment_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailMuseum extends StatefulWidget {
  final Museum museum;

  const DetailMuseum({Key? key, required this.museum}) : super(key: key);

  @override
  State<DetailMuseum> createState() => _DetailMuseumState();
}

class _DetailMuseumState extends State<DetailMuseum> {
  final ApiService apiService = ApiService();

  @override
  void initState() {
    getFavorites();
    getProfile();

    widget.museum.getListKomentar().then((value) => {
          setState(() => {listComments = value})
        });

    super.initState();
  }

  bool isFavorite = false;
  List<Comment> listComments = [];

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final commentController = TextEditingController();

  void updateButton() {
    setState(() {
      if (isFavorite) {
        isFavorite = false;
        apiService.deleteFavorite(widget.museum.getId());
        user_1
            .getFavoritMuseum()
            .removeWhere((item) => item.id == widget.museum.getId());
      } else {
        isFavorite = true;
        ApiService().storeFavorite(widget.museum.getId());

        user_1.getFavoritMuseum().add(widget.museum);
      }
    });
  }

  void uploadComment(String isiComment) {
    // get current date
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    // create new comment instance
    Comment newComment = Comment(
        id: listComment.length,
        museumId: widget.museum.getId(),
        namaPengunggah: user_1.getNama(),
        tanggalUnggah: date.toString().replaceAll("00:00:00.000", ""),
        komentar: isiComment);

    setState(() {
      // save to user comment list
      user_1.getKomentar().add(newComment);

      // add to overall comment list
      listComment.add(newComment);

      // add to museum comment list
      // widget.museum.getListKomentar().add(newComment);
    });

    widget.museum.postKomentar(newComment).then((value) => {
          setState(() => {listComments = value})
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // cek apakah museum ini ada di favorite-nya user
    for (int i = 0; i < user_1.getFavoritMuseum().length; i++) {
      if (identical(
          widget.museum.getId(), user_1.getFavoritMuseum()[i].getId())) {
        isFavorite = true;
        break;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // detail header
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ImageNetwork(
                        image: widget.museum.getGambarUtama(),
                        width: size.width,
                        height: size.height * 0.5,
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
                      //   'assets/images/' + widget.museum.getGambarUtama(),
                      //   width: size.width,
                      //   height: size.height * 0.5,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // back button
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.6),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.blue,
                              ),
                            ),
                          ),

                          // favorite button
                          InkWell(
                            onTap: updateButton,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.6),
                              ),
                              child: (isFavorite)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Color(0xFFDA3E52),
                                    )
                                  : const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Color(0xFFDA3E52),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // museum name, city and rating
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // nama museum
                              Text(
                                widget.museum.getNama(),
                                style: const TextStyle(
                                  fontFamily: "Cera Round Pro 2",
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              // kota museum
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xFF555B6E),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.museum.getAlamatKota(),
                                    style: const TextStyle(
                                      color: Color(0xFF89B0AE),
                                      fontFamily: "Cera Round Pro 2",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // rating museum
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              Text(
                                widget.museum.getRating().toString(),
                                style: const TextStyle(
                                  fontFamily: "Cera Round Pro 2",
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // museum description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 2.5,
                      width: 50,
                      color: const Color(0xFFFFD6BA),
                    ),
                    const SizedBox(height: 5),
                    ReadMoreText(
                      widget.museum.getDeskripsi(),
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Show less',
                      colorClickableText: const Color(0xFF89B0AE),
                      trimMode: TrimMode.Length,
                      trimLength: 120,
                      // textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Color(0xFF444444),
                        fontFamily: "Cera Round Pro 2",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // museum address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Address",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 2.5,
                      width: 50,
                      color: const Color(0xFFFFD6BA),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.museum.getAlamatLengkap(),
                      // textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Color(0xFF444444),
                        fontFamily: "Cera Round Pro 2",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // museum comments
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Comments",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 2.5,
                      width: 50,
                      color: const Color(0xFFFFD6BA),
                    ),

                    const SizedBox(height: 10),

                    // input comments
                    Row(
                      children: [
                        // text field
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade100,
                            ),
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Input your comment",
                                hintStyle: TextStyle(
                                  fontFamily: "Cera Round Pro 2",
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // button submit
                        InkWell(
                          onTap: () {
                            if (commentController.text == "") {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    'Comment is empty!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: const Text(
                                    'Write some comment before upload it.',
                                    style: TextStyle(
                                      height: 1.5,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
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
                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    'Upload your comment?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: const Text(
                                    'Once uploaded it cannot be changed anymore',
                                    style: TextStyle(
                                      height: 1.5,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                        context,
                                        'Cancel',
                                      ),
                                      child: const Text(
                                        'Cancel',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        uploadComment(commentController.text);
                                        commentController
                                            .clear(); // clear text field
                                        Navigator.pop(
                                          context,
                                          'YES',
                                        );
                                      },
                                      child: const Text(
                                        'YES',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade400,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade400.withOpacity(0.6),
                                  offset: Offset.zero,
                                  spreadRadius: 2.5,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.comment,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // view comments
                    (listComments.isEmpty)
                        ? Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/feedback.png',
                                    height: size.height * 0.2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const Text(
                                  "No comments yet",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Be the first one to comment!",
                                  style: TextStyle(
                                    color: Color(0xFFADA4A5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: listComments.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: CommentCard(
                                  komentar: listComments[index],
                                ),
                              );
                            },
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // button open virtual tour
      bottomNavigationBar: SizedBox(
        height: 100,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewMuseum(
                  title: widget.museum.getNama(),
                  museumUrl: widget.museum.getLinkVirtualTour(),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF89B0AE),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF89B0AE).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Open Virtual Tour",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Cera Round Pro 2",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.camera_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
