import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/models/feedback/feedback.dart';
import 'package:thanhhoa_garden/models/order/order.dart';
import 'package:thanhhoa_garden/screens/bonsai/bonsaidetail.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class ListFeebback extends StatefulWidget {
  List<FeedbackModel>? listData;
  String? wherecall;
  ListFeebback({super.key, this.listData, this.wherecall});

  @override
  State<ListFeebback> createState() => _ListFeebbackState();
}

class _ListFeebbackState extends State<ListFeebback> {
  User user = getCuctomerIDFromSharedPrefs();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.wherecall == 'OrderFeedback')
        ? _listFeedbackFromOrderScreen()
        : (widget.listData!.isNotEmpty)
            ? _listFeedbackScreen()
            : Container();
  }

  Widget _FeedbackTab(FeedbackModel feedback) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              (widget.wherecall == 'OrderFeedback')
                                  ? user.avatar
                                  : feedback.showCustomerModel!.avatar))),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width - 125,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 145,
                            child: AutoSizeText(
                              (widget.wherecall == 'OrderFeedback')
                                  ? user.fullName
                                  : feedback.showCustomerModel!.fullName,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: darkText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          const Spacer(),
                          for (int i = 0;
                              i <
                                  int.parse(feedback.ratingModel!.description
                                      .toString()
                                      .split('.')[0]);
                              i++)
                            const Icon(Icons.star, color: Colors.yellow),
                          for (int i = 0;
                              i <
                                  5 -
                                      int.parse(feedback
                                          .ratingModel!.description
                                          .toString()
                                          .split('.')[0]);
                              i++)
                            const Icon(Icons.star_border_outlined,
                                color: Colors.yellow),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width - 125,
                          child: AutoSizeText(
                            feedback.description.toString().substring(
                                0,
                                (feedback.description.toString().length >= 100)
                                    ? 100
                                    : feedback.description.toString().length),
                            maxLines: 3,
                            style: const TextStyle(
                                color: darkText, fontSize: 17, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                    (feedback.listImg!.isEmpty)
                        ? Container()
                        : Container(
                            width: size.width - 125,
                            child: SingleChildScrollView(
                              // shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(children: <Widget>[
                                for (int i = 0;
                                    i < feedback.listImg!.length;
                                    i++)
                                  GestureDetector(
                                    onTap: () {
                                      PopupBanner(
                                        fit: BoxFit.cover,
                                        height: size.width,
                                        context: context,
                                        images: [
                                          for (int i = 0;
                                              i < feedback.listImg!.length;
                                              i++)
                                            feedback.listImg![i].url
                                        ],
                                        autoSlide: false,
                                        dotsAlignment: Alignment.bottomCenter,
                                        dotsColorActive: buttonColor,
                                        dotsColorInactive:
                                            Colors.grey.withOpacity(0.5),
                                        onClick: (index) {
                                          debugPrint("CLICKED $index");
                                        },
                                      ).show();
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.all(5),
                                        height: (size.width / 5) - 20,
                                        width: (size.width / 5) - 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  feedback.listImg![i].url)),
                                        )),
                                  ),
                              ]),
                            )),
                    Row(
                      children: [
                        Text(
                          getDate(feedback.createdDate),
                          maxLines: 1,
                          style: const TextStyle(
                              color: darkText,
                              // fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )),
        Center(
          child: Container(
            // margin: const EdgeInsets.all(8),
            height: 1.5,
            width: size.width,
            decoration: const BoxDecoration(color: divince),
          ),
        ),
        (widget.wherecall == 'OrderFeedback')
            ? Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BonsaiDetail(
                            bonsaiID: feedback.showPlantModel!.id,
                            name: feedback.showPlantModel!.plantName),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(5),
                              height: (size.width / 5) - 20,
                              width: (size.width / 5) - 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        feedback.showPlantModel!.image ??
                                            NoIMG)),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            feedback.showPlantModel!.plantName,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          const Text(
                            '>>',
                            style: TextStyle(
                                color: buttonColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    decoration: const BoxDecoration(color: divince),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _listFeedbackFromOrderScreen() {
    List<FeedbackModel> list = widget.listData!;
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _FeedbackTab(list[index]);
      },
    );
  }

  Widget _listFeedbackScreen() {
    List<FeedbackModel> list = widget.listData!;
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _FeedbackTab(list[index]);
      },
    );
  }
}
