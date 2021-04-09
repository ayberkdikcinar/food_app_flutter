import 'dart:convert';
import 'dart:io';

import 'IApiService.dart';
import 'package:http/http.dart' as http;

import '../model/area_model.dart';
import '../model/category_model.dart';
import '../model/meal_detail_model.dart';

class ApiService extends IApiService {
  @override
  Future<List<Area>> getAreaList() async {
    final areaListPath = 'https://www.themealdb.com/api/json/v1/1/list.php?a=list';
    var _url = Uri.parse(areaListPath);
    var _response = await http.get(_url);
    final _jsonResponse = jsonDecode(_response.body)['meals'] as List?;
    switch (_response.statusCode) {
      case HttpStatus.ok:
        var _areas = _jsonResponse!.map<Area>((e) => Area().fromJson(e)).toList();
        return _areas;
      default:
        return Future.error('');
    }
  }

  @override
  Future<List<MealDetail>> getMealListByCategoryName(String? categoryName) async {
    final mealListPath = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName';
    var _url = Uri.parse(mealListPath);
    var _response = await http.get(_url);
    final _jsonResponse = jsonDecode(_response.body)['meals'] as List?;

    switch (_response.statusCode) {
      case HttpStatus.ok:
        if (_jsonResponse != null) {
          var _mealList = _jsonResponse.map<MealDetail>((e) => MealDetail().fromJson(e)).toList();
          return _mealList;
        }
        return [];

      default:
        return Future.error('');
    }
  }

  @override
  Future<List<MealDetail>> getMealDetailById(String? mealId) async {
    final mealListPath = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId';
    var _url = Uri.parse(mealListPath);
    var _response = await http.get(_url);
    final _jsonResponse = jsonDecode(_response.body)['meals'] as List?;

    switch (_response.statusCode) {
      case HttpStatus.ok:
        var _mealList = _jsonResponse!.map<MealDetail>((e) => MealDetail().fromJson(e)).toList();
        return _mealList;

      default:
        return Future.error('');
    }
  }

  @override
  Future<List<Category>> getCategoryList() async {
    final categoryListPath = 'https://www.themealdb.com/api/json/v1/1/categories.php';
    var _url = Uri.parse(categoryListPath);
    var _response = await http.get(_url);
    final _jsonResponse = jsonDecode(_response.body)['categories'] as List?;
    if (_jsonResponse != null) {
      switch (_response.statusCode) {
        case HttpStatus.ok:
          var _categories = _jsonResponse.map<Category>((e) => Category().fromJson(e)).toList();
          return _categories;

        default:
          return [];
      }
    }
    return Future.error('');
  }

  @override
  Future<List<MealDetail>> getMealListByArea(String? areaName) async {
    final mealListPath = 'https://www.themealdb.com/api/json/v1/1/filter.php?a=$areaName';
    var _url = Uri.parse(mealListPath);
    var _response = await http.get(_url);
    final _jsonResponse = jsonDecode(_response.body)['meals'] as List?;
    if (_jsonResponse != null) {
      switch (_response.statusCode) {
        case HttpStatus.ok:
          var _mealList = _jsonResponse.map<MealDetail>((e) => MealDetail().fromJson(e)).toList();
          return _mealList;

        default:
          return [];
      }
    }
    return Future.error('');
  }
}
