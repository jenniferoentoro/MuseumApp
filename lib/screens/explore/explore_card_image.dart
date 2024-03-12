import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:museum_app/models/museum.dart';

class ExploreCardImage extends StatelessWidget {
  const ExploreCardImage({
    Key? key,
    required this.museum,
    required this.size,
  }) : super(key: key);

  final Museum museum;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: ImageNetwork(
          image: museum.getGambarUtama(),
          width: size.width,
          height: size.height * 0.2,
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
        //   height: size.height * 0.2,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
