import 'package:flutter/material.dart';

class DefaultTabVM with ChangeNotifier {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  PageController get pageController => _pageController;
  int get pageIndex => _pageIndex;

  void setPageIndex(int index) {
    _pageIndex = index;
  }
}
