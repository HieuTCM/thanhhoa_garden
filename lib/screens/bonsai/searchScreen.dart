import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_state.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/cart/cart_state.dart';
import 'package:thanhhoa_garden/blocs/bonsai/category/cate_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/category/cate_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/category/cate_state.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/bonsai/listBonsai_Component.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:thanhhoa_garden/providers/bonsai/cart_provider.dart';

class SearchScreen extends StatefulWidget {
  StreamSubscription<CartState>? cartStateSubscription;
  Stream<CartState>? cartStream;
  SearchScreen({super.key, this.cartStateSubscription, this.cartStream});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  late BonsaiBloc bonsaiBloc;
  late CategoryBloc categoryBloc;

  StreamSubscription<BonsaiState>? _bonsaiStateSubscription;
  StreamSubscription<CategoryState>? _CategoryStateSubscription;

  late Stream<BonsaiState> bonsaiStream;
  late Stream<CategoryState> categoryStream;

  late CartBloc cartBloc;

  var selectedTab = 0;

  @override
  void initState() {
    super.initState();
    bonsaiBloc = Provider.of<BonsaiBloc>(context, listen: false);
    categoryBloc = Provider.of<CategoryBloc>(context, listen: false);

    bonsaiStream = bonsaiBloc.authStateStream;
    categoryStream = categoryBloc.categoryStateStream;

    bonsaiBloc.send(SearchBonsaiEvent());
    categoryBloc.send(GetAllCategoryEvent());

    _bonsaiStateSubscription = bonsaiStream.listen((event) {});
    _CategoryStateSubscription = categoryStream.listen((event) {});
  }

  @override
  void didChangeDependencies() {
    _bonsaiStateSubscription?.cancel();
    _CategoryStateSubscription?.cancel();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bonsaiBloc.dispose();
    categoryBloc.dispose();
    _bonsaiStateSubscription?.cancel();
    _CategoryStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: Builder(builder: (context) {
        return _floatingButton();
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        height: size.height,
        child: Column(children: [
          const SizedBox(
            height: 35,
          ),
          //search Bar
          AppBarWiget(midle: _seachField(), tail: _filterIcon()),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              height: 1,
              width: 250,
              decoration: const BoxDecoration(color: buttonColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Category list
          // _cateList(),
          Container(
            height: 50,
            width: size.width,
            child: _cateList(),
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(color: divince),
          ),
          //Bonsai List
          Expanded(child: _bonsaiList())
        ]),
      ),
    );
  }

  Widget _bonsaiList() {
    return StreamBuilder<BonsaiState>(
      stream: bonsaiStream,
      initialData: BonsaiInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is BonsaiLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListBonsaiSuccess) {
          return state.listBonsai == null
              ? Container()
              : ListBonsai(
                  listBonsai: state.listBonsai,
                  wherecall: 'Search Screen',
                  cartStateSubscription: widget.cartStateSubscription,
                  cartStream: widget.cartStream,
                );
        } else if (state is BonsaiFailure) {
          return Text(state.errorMessage);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _listCategory(List<PlantCategory> list) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = index;
              });
              bonsaiBloc.send(SearchBonsaiEvent());
            },
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: (selectedTab == index) ? buttonColor : barColor,
                  borderRadius: BorderRadius.circular(50)),
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: AutoSizeText(list[index].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: (selectedTab == index) ? lightText : HintIcon)),
            ),
          );
        },
        itemCount: list.length);
  }

  Widget _cateList() {
    return StreamBuilder<CategoryState>(
      stream: categoryStream,
      initialData: CategoryInitial(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListCategorySuccess) {
          return state.listCategory == null
              ? Container()
              : _listCategory(state.listCategory!);
        } else if (state is CategoryFailure) {
          return Text(state.errorMessage);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _floatingButton() {
    return DraggableFab(
      child: SizedBox(
        height: 55,
        width: 55,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: buttonColor, width: 3.0),
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(500.0),
                    onTap: () {},
                    child: const FaIcon(FontAwesomeIcons.cartShopping),
                  ),
                ),
              ),
              Positioned(
                right: 1,
                top: 1,
                child: ClipOval(
                  child: Container(
                    color: Colors.red,
                    width: 20,
                    height: 20,
                    child: Consumer<CartProvider>(
                      builder: (context, value, _) {
                        return Center(
                            child: Text(
                          (value.lits == null)
                              ? '0'
                              : value.lits!.length.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _seachField() {
    return SizedBox(
      width: 250,
      height: 50,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(width: 3, color: Colors.black)),
            hintText: 'Tìm kiếm',
            suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search))),
      ),
    );
  }

  Widget _filterIcon() {
    return Center(
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.filter_alt_outlined,
            color: buttonColor,
            size: 40,
          )),
    );
  }
}
