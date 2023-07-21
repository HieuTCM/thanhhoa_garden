import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/store/storeBloc.dart';
import 'package:thanhhoa_garden/blocs/store/storeEvent.dart';
import 'package:thanhhoa_garden/blocs/store/storeState.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/sideBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/store/store.dart';
import 'package:thanhhoa_garden/providers/store/store_provider.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late StoreBloc storeBloc;
  late Stream<StoreState> storeStream;
  @override
  void initState() {
    storeBloc = Provider.of<StoreBloc>(context, listen: false);

    storeStream = storeBloc.storeStream;

    storeBloc.send(GetStore());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    storeBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: background,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
          ),
          AppBarWiget(
            title: 'Danh Sách Cửa Hàng',
          ),
          StreamBuilder<StoreState>(
            stream: storeStream,
            initialData: StoreInitial(),
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state is StoreLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is StoreSuccess) {
                return state.list == null
                    ? Container()
                    : Container(
                        height: MediaQuery.of(context).size.height - 100,
                        child: _ListStore(state.list));
              } else if (state is StoreFailure) {
                return Text(state.errorMessage);
              } else {
                return const Text('Load faild');
              }
            },
          ),
        ],
      )),
    );
  }

  Widget _ListStore(List<Store> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => _storetab(list[index]),
    );
  }

  Widget _storetab(Store store) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(minHeight: 100),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  width: 30,
                  child: Icon(
                    Icons.place,
                    color: Colors.red,
                  )),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: AutoSizeText(
                                  'Chi Nhánh: ${store.storeName}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: darkText,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Địa chỉ : ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: darkText,
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: AutoSizeText(
                              // maxLines: 2,
                              minFontSize: 16,
                              '${store.address}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Số điện thoại : ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: darkText,
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: AutoSizeText(
                              // maxLines: 2,
                              minFontSize: 16,
                              '${store.phone}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ]),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.grey,
            height: 2,
          )
        ],
      ),
    );
  }
}
