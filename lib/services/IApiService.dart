import 'package:food/model/area_model.dart';
import 'package:food/model/category_model.dart';
import 'package:food/model/meal_detail_model.dart';

abstract class IApiService {
  Future<List<Category>> getCategoryList();
  Future<List<Area>> getAreaList();
  Future<List<MealDetail>> getMealListByCategoryName(String? categoryName);
  Future<List<MealDetail>> getMealDetailById(String? mealId);
  //Future<List<MealDetail>> getMealListByArea(String? areaName);
}
