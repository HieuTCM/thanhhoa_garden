// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_interpolation_to_compose_strings, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_state.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/screens/bonsai/bonsaidetail.dart';

class ListBonsai extends StatefulWidget {
  List<Bonsai>? listBonsai;
  String? wherecall;
  StreamSubscription<CartState>? cartStateSubscription;
  Stream<CartState>? cartStream;
  ListBonsai(
      {required this.listBonsai,
      super.key,
      this.wherecall,
      this.cartStateSubscription,
      this.cartStream});

  @override
  State<ListBonsai> createState() => _ListBonsaiState();
}

class _ListBonsaiState extends State<ListBonsai> {
  late CartBloc cartBloc;
  // int? count;
  @override
  void initState() {
    cartBloc = Provider.of<CartBloc>(context, listen: false);
    //     widget.cartStateSubscription = widget.cartStream?.listen((event) {
    //   if (event is CartSuccess) {
    //     count = event.Cart!;
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    // cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _listBonsai(widget.listBonsai);
  }

  Widget _listBonsai(List<Bonsai>? listBonsai) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: (widget.wherecall != null)
          ? const ScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: listBonsai!.length,
      itemBuilder: (context, index) {
        return _BonsaiTab(listBonsai[index]);
      },
    );
  }

  Widget _BonsaiTab(Bonsai bonsai) {
    var f = NumberFormat("###,###,###", "en_US");

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BonsaiDetail(bonsai: bonsai),
        ));
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: tabBackground, borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Container(
              padding: EdgeInsets.zero,
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(bonsai.listImg![0].imgurl)),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 18, right: 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20 - 150 - 36,
                    height: 25,
                    child: Row(
                      children: [
                        Text(
                          bonsai.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        IconButton(
                            color: buttonColor,
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                            iconSize: 30,
                            onPressed: () {
                              cartBloc.send(AddtoCart(bonsai));
                            },
                            icon: const Icon(Icons.add_shopping_cart_outlined))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kèm chậu: ${bonsai.with_pot == 'True' ? 'Có' : 'Không' ''}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${'Tổng chiều cao: ~ ' + bonsai.height} Cm',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20 - 150 - 36,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${f.format(double.parse(bonsai.price))} đ',
                          style:
                              const TextStyle(fontSize: 18, color: priceColor),
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: buttonColor),
                          child: const Text(
                            "Chi tiết",
                            style: TextStyle(
                              color: lightText,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          )
        ]),
      ),
    );
  }
}
