import 'package:flutter/material.dart';
import 'package:museum_app/models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment komentar;
  const CommentCard({Key? key, required this.komentar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15.0),
        // border: Border.all(
        //   color: const Color(0xFF1C1C1C),
        //   width: 2.0,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 0, //spread radius
            blurRadius: 4, // blur radius
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // user icon
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
            ),
            child: Card(
              elevation: 1.0,
              color: Colors.grey[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: const BorderSide(
                  color: Colors.black,
                  width: 2.5,
                ),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.black,
                size: 30.0,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // detail komentar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // nama pengunggah
                    Expanded(
                      flex: 2,
                      child: Text(
                        komentar.getNamaPengunggah(),
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // tanggal unggah
                    Expanded(
                      flex: 1,
                      child: Text(
                        komentar.getTanggalUnggah(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: "Cera Round Pro 2 ",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // isi komentar
                Text(
                  komentar.getKomentar(),
                  // textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Color(0xFF444444),
                    fontFamily: "Cera Round Pro 2",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
