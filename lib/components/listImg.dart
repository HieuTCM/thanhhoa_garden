import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsaiImg.dart';

class ListImg extends StatefulWidget {
  List<PlantImage> listImage;
  ListImg({super.key, required this.listImage});

  @override
  State<ListImg> createState() => _ListImgState();
}

class _ListImgState extends State<ListImg> {
  List<PlantImage> listImage = [];
  int index = 0;
  @override
  void initState() {
    listImage = widget.listImage;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      width: size.width,
      child: Row(
        children: [
          IndexedStack(
            index: index,
            children: <Widget>[
              for (var img in listImage)
                Container(
                    height: 275,
                    width: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(img.imgurl)),
                    )),
            ],
          ),
          const Spacer(),
          SingleChildScrollView(
            child: Column(children: <Widget>[
              for (int i = 0; i < listImage.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = i;
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            opacity: (index == i) ? 1 : 0.5,
                            fit: BoxFit.cover,
                            image: NetworkImage(listImage[i].imgurl)),
                      )),
                ),
            ]),
          )
        ],
      ),
    );
  }
}
