import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/meal_detail_model.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class ProductViewModel with ChangeNotifier {
  FavouritesDatabaseProvider? favouritesDatabaseProvider = FavouritesDatabaseProvider.instance;
  final ApiService _apiService = ApiService();
  List<MealDetail?>? _favMealList = [];
  ProductViewModel() {
    favouritesDatabaseProvider!.open();
    getList();
  }
  List<MealDetail?>? get favMealList => _favMealList;

  Future<bool> getList() async {
    _favMealList = await favouritesDatabaseProvider!.getList();
    if (_favMealList!.isEmpty) {
      return false;
    } else {
      return true;
    }
    //notifyListeners();
  }

  Future<bool> searchListById(String id) async => await favouritesDatabaseProvider!.mealIsExist(id);

  Future<int> deleteFromFavourite(String id) async {
    await favouritesDatabaseProvider!.delete(id);
    _favMealList?.removeWhere((element) => element?.idMeal == id);
    notifyListeners();
    return 0;
  }

  Future<int> addToFavourite(MealDetail meal) async {
    await favouritesDatabaseProvider!.insert(meal);
    _favMealList?.add(meal);
    notifyListeners();
    return 1;
  }

  Future<List<MealDetail>> getMealDetailById(String mealId) async {
    return await _apiService.getMealDetailById(mealId);
  }

  Future<List<MealDetail>> getMealListByCategoryName(String categoryName) async {
    return await _apiService.getMealListByCategoryName(categoryName);
  }

  Future<List<MealDetail>> getMealListByArea(String areaName) async {
    return await _apiService.getMealListByArea(areaName);
  }
}
