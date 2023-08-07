import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Circular extends StatefulWidget {
  const Circular({Key? key}) : super(key: key);

  @override
  State<Circular> createState() => _CircularState();
}

class _CircularState extends State<Circular> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: barColor,
      ),
    );
  }
}
