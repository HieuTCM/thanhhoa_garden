import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thanhhoa_garden/screens/contract/contactHistoryScreen.dart';
import 'package:thanhhoa_garden/screens/order/orderHistoryScreen.dart';

class HistoryScreen extends StatefulWidget {
  final int index;
  HistoryScreen({super.key, required this.index});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int? indexStack;
  @override
  void initState() {
    indexStack = widget.index;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  goOrderScreen() {
    setState(() {
      indexStack = 0;
    });
  }

  goContactScreen() {
    setState(() {
      indexStack = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: indexStack,
      children: [
        OrderHistoryScreen(callback: goContactScreen),
        ContactHistorySreen(
          callBack: goOrderScreen,
        )
      ],
    );
  }
}
