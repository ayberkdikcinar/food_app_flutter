import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/model/meal_detail_model.dart';
import 'package:food/services/db_service.dart';

class ProductViewModel with ChangeNotifier {
  FavouritesDatabaseProvider? favouritesDatabaseProvider = FavouritesDatabaseProvider.instance;

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
}
