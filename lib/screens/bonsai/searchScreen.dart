import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_state.dart';

import 'package:thanhhoa_garden/blocs/bonsai/category/cate_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/category/cate_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/category/cate_state.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/components/appBar.dart';
import 'package:thanhhoa_garden/components/bonsai/listBonsai_Component.dart';
import 'package:thanhhoa_garden/components/cart/cartButton.dart';
import 'package:thanhhoa_garden/components/sideBar.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';
import 'package:thanhhoa_garden/providers/bonsai/category_provider.dart';

class SearchScreen extends StatefulWidget {
  // StreamSubscription<CartState>? cartStateSubscription;
  // Stream<CartState>? cartStream;
  SearchScreen({
    super.key,
    //  this.cartStateSubscription, this.cartStream
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // RangeValues _currentRangeValues = const RangeValues(0, 0);
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  List<Bonsai> listPlant = [];

  late BonsaiBloc bonsaiBloc;
  late CategoryBloc categoryBloc;

  StreamSubscription<BonsaiState>? _bonsaiStateSubscription;
  StreamSubscription<CategoryState>? _CategoryStateSubscription;

  late Stream<BonsaiState> bonsaiStream;
  late Stream<CategoryState> categoryStream;

  late CartBloc cartBloc;
  List<PlantCategory> listCategory = [];
  var selectedTab = 0;
  String cateID = '';
  bool isLoading = false;

  int pageNo = 0;
  int PageSize = 10;

  @override
  void initState() {
    super.initState();
    bonsaiBloc = Provider.of<BonsaiBloc>(context, listen: false);
    categoryBloc = Provider.of<CategoryBloc>(context, listen: false);

    bonsaiStream = bonsaiBloc.authStateStream;
    categoryStream = categoryBloc.categoryStateStream;
    _getPlant(0, PageSize, 'ID', true);
    // bonsaiBloc.send(SearchBonsaiEvent());
    categoryBloc.send(GetAllCategoryEvent());

    _bonsaiStateSubscription = bonsaiStream.listen((event) {});
    _CategoryStateSubscription = categoryStream.listen((event) {});
    _scrollController.addListener(() {
      _getMorePlant();
    });
    getCategory();
  }

  getCategory() async {
    CategoryProvider provider = CategoryProvider();
    await provider.getAllCategory().then((value) async {
      setState(() {
        listCategory = provider.listCategory!;
      });
    });
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

  _getMorePlant() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      int totalPage = listPlant[0].totalPage.round() - 1;
      if (pageNo >= totalPage) {
        // setState(() {
        //   isLoading = false;
        // });
        Fluttertoast.showToast(
            msg: "Hết trang",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Đang tải thêm cây ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: buttonColor,
            textColor: Colors.white,
            fontSize: 16.0);
        pageNo++;
        int nextPage = pageNo;
        await _searchPlant(
            nextPage, PageSize, 'ID', true, null, cateID, null, null);
      }
    }
  }

  _getPlant(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
  ) {
    bonsaiBloc.send(GetAllBonsaiEvent(
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        sortAsc: sortAsc,
        listBonsai: listPlant));
  }

  _searchPlant(
    int pageNo,
    int pageSize,
    String sortBy,
    bool sortAsc,
    String? plantName,
    String? categoryID,
    double? min,
    double? max,
  ) {
    bonsaiBloc.send(GetAllBonsaiEvent(
        listBonsai: listPlant,
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        sortAsc: sortAsc,
        plantName: plantName,
        categoryID: categoryID,
        min: min,
        max: max));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: background,
      floatingActionButton: Builder(builder: (context) {
        return const CartButton();
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
          Expanded(child: _bonsaiList()),
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
          listPlant = [...state.listBonsai!];
          return listPlant.isEmpty
              ? const Center(
                  child: Text('Không tìm thấy Bonsai'),
                )
              : ListBonsai(
                  scrollController: _scrollController,
                  listBonsai: listPlant,
                  wherecall: 'Search Screen',
                  // cartStateSubscription: widget.cartStateSubscription,
                  // cartStream: widget.cartStream,
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
                cateID = list[index].categoryID;
                listPlant.clear();
                pageNo = 0;
              });
              _searchController.clear();
              _searchPlant(0, PageSize, 'ID', true, null, cateID, null, null);
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
              child: AutoSizeText(list[index].categoryName,
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
            hintText: 'Tên cây cảnh',
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    listPlant.clear();
                    pageNo = 0;
                  });
                  _searchPlant(0, 10, 'ID', true, _searchController.text,
                      cateID, null, null);
                },
                icon: Icon(Icons.search))),
      ),
    );
  }

  Widget _filterIcon() {
    return Center(
      child: IconButton(
          onPressed: () {
            _showButtonSheet();
          },
          icon: const Icon(
            Icons.filter_alt_outlined,
            color: buttonColor,
            size: 40,
          )),
    );
  }

  _showButtonSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              height: 400,
              color: background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row(
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(10),
                  //       child: const Text('Lọc giá :',
                  //           style: TextStyle(fontSize: 16)),
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Text(
                  //           'Từ  ${f.format(_currentRangeValues.start.round())} đ',
                  //           style: const TextStyle(fontSize: 16)),
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(20),
                  //       child: Text(
                  //           ' Đến  ${f.format(_currentRangeValues.end.round())} đ',
                  //           style: const TextStyle(fontSize: 16)),
                  //     ),
                  //   ],
                  // ),
                  // RangeSlider(
                  //   values: _currentRangeValues,
                  //   min: 0,
                  //   max: 100000000,
                  //   divisions: 1000,
                  //   labels: RangeLabels(
                  //     '${f.format(_currentRangeValues.start.round())} đ',
                  //     '${f.format(_currentRangeValues.end.round())} đ',
                  //   ),
                  //   onChanged: (RangeValues values) {
                  //     setState(() {
                  //       _currentRangeValues = values;
                  //     });
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(20),
                          child: const Text('Danh mục :',
                              style: TextStyle(fontSize: 16))),
                    ],
                  ),
                  SizedBox(
                      height: 250,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 50,
                        clipBehavior: Clip.antiAlias,
                        onSelectedItemChanged: (index) {
                          setState(
                            () {
                              setfilter(index);
                              cateID = listCategory[index].categoryID;
                            },
                          );
                        },
                        childDelegate: ListWheelChildLoopingListDelegate(
                          children: [
                            for (int i = 0; i < listCategory.length; i++)
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: i == selectedTab
                                        ? buttonColor
                                        : barColor),
                                child: AutoSizeText(
                                  listCategory[i].categoryName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: (i == selectedTab
                                          ? Colors.black
                                          : Colors.grey)),
                                ),
                              )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        search(cateID);
                      },
                      child: Container(
                        height: 45,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          'Tìm Kiếm',
                          style: TextStyle(
                              color: lightText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  setfilter(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  search(String cateID) {
    setState(() {
      listPlant.clear();
      pageNo = 0;
    });
    // _searchController.clear();
    _searchPlant(
        0, PageSize, 'ID', true, _searchController.text, cateID, null, null);
  }
}
