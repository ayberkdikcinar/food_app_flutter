import 'package:flutter/cupertino.dart';
import 'package:food/model/area_model.dart';
import 'package:food/model/category_model.dart';
import 'package:food/services/api_service.dart';

enum ViewState { Idle, Busy }

class HomeViewModel with ChangeNotifier {
  final ApiService _apiService = ApiService();
  var _viewState = ViewState.Idle;
  List<Category> _categoryList = [];
  List<Area> _areaList = [];
  HomeViewModel() {
    getCategories();
    getAreas();
  }

  Future<void> getCategories() async {
    try {
      setState(ViewState.Busy);
      _categoryList = await _apiService.getCategoryList();
    } finally {
      setState(ViewState.Idle);
    }
  }

  Future<void> getAreas() async {
    try {
      setState(ViewState.Busy);
      _areaList = await _apiService.getAreaList();
    } finally {
      setState(ViewState.Idle);
    }
  }

  void setState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  List<Area> get areaList => _areaList;
  List<Category> get categoryList => _categoryList;
  ViewState get viewState => _viewState;
}
