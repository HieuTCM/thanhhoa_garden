import 'package:flutter/material.dart';
import 'package:thanhhoa_garden/constants/constants.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({Key? key, required this.title, required this.width})
      : super(key: key);
  final title;
  final width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: width,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(45)),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
      )),
    );
  }
}
