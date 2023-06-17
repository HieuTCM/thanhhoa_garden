import 'package:thanhhoa_garden/models/bonsai/plantCategory.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class ListCategorySuccess extends CategoryState {
  final List<PlantCategory>? listCategory;
  ListCategorySuccess({required this.listCategory});
}

class CategorySuccess extends CategoryState {
  final PlantCategory? Category;
  CategorySuccess({required this.Category});
}

class CategoryFailure extends CategoryState {
  final String errorMessage;
  CategoryFailure({required this.errorMessage});
}
