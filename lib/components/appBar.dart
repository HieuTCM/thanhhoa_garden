import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thanhhoa_garden/constants/constants.dart';

class AppBarWiget extends StatefulWidget {
  final Widget? midle;
  final Widget? tail;
  final String? title;
  AppBarWiget({super.key, this.midle, this.tail, this.title});

  @override
  State<AppBarWiget> createState() => _AppBarWigetState();
}

class _AppBarWigetState extends State<AppBarWiget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      // height: 65,
      width: size.width,
      // decoration: const BoxDecoration(color: Colors.amber),
      child: Row(
        children: [
          Center(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: buttonColor,
                  size: 40,
                )),
          ),
          const Spacer(),
          (widget.midle == null)
              ? Container(
                  width: 250,
                  height: 50,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    widget.title!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                )
              : widget.midle!,
          const Spacer(),
          (widget.tail == null) ? const SizedBox() : widget.tail!,
        ],
      ),
    );
  }
}
