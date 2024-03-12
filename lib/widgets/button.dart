import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const RoundedButton(
      {Key? key, required this.icon, required this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Card(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: color, width: 2.0),
          ),
          color: null,
          child: Icon(
            icon,
            color: color,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
