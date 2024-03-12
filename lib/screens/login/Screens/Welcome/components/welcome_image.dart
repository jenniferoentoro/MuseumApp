import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:museum_app/screens/login/constants2.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "WELCOME TO VIRTUAL TOUR MUSEUM",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              // child: SvgPicture.asset(
              //   "assets/icons/chat.svg",
              // ),
              child: new Image.asset('assets/images/Manpro2.png'),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
