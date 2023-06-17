import 'dart:async';

import 'package:thanhhoa_garden/blocs/bonsai/category/cate_event.dart';
import 'package:thanhhoa_garden/blocs/bonsai/category/cate_state.dart';
import 'package:thanhhoa_garden/providers/bonsai/category_provider.dart';

class CategoryBloc {
  final CategoryProvider _categoryProvider;
  final StreamController<CategoryState> _categoryController =
      StreamController<CategoryState>();

  Stream<CategoryState> get categoryStateStream =>
      _categoryController.stream.asBroadcastStream();
  StreamController<CategoryState> get categoryStateController =>
      _categoryController;

  CategoryBloc({required CategoryProvider categoryProvider})
      : _categoryProvider = categoryProvider {
    _categoryController.add(CategoryInitial());
  }

  void send(CategoryEvent event) async {
    switch (event.runtimeType) {
      case GetAllCategoryEvent:
        _categoryController.add(CategoryLoading());
        await _categoryProvider.getAllCategory().then((value) {
          if (value) {
            final listCategory = _categoryProvider.listCategory;
            _categoryController
                .add(ListCategorySuccess(listCategory: listCategory));
          } else {
            _categoryController
                .add(CategoryFailure(errorMessage: 'Get Bonsai List Failed'));
          }
        });
        break;
      case GetByIDCategoryEvent:
        break;
    }
  }

  void dispose() {
    _categoryController.close();
  }
}
