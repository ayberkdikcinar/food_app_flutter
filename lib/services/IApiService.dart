import '../model/area_model.dart';
import '../model/category_model.dart';
import '../model/meal_detail_model.dart';

abstract class IApiService {
  Future<List<Category>> getCategoryList();
  Future<List<Area>> getAreaList();
  Future<List<MealDetail>> getMealListByCategoryName(String? categoryName);
  Future<List<MealDetail>> getMealDetailById(String? mealId);
  Future<List<MealDetail>> getMealListByArea(String? areaName);
}
