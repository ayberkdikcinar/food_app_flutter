import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'default_tab_viewmodel.dart';
import '../product/view/favourite_view.dart';
import '../home/home_view.dart';

class DefaulTabView extends StatefulWidget {
  const DefaulTabView({Key? key}) : super(key: key);

  @override
  _DefaulTabViewState createState() => _DefaulTabViewState();
}

class _DefaulTabViewState extends State<DefaulTabView> {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<DefaultTabVM>(context, listen: false);
    return Scaffold(
        body: PageView(
          controller: vm.pageController,
          onPageChanged: (value) {
            vm.setPageIndex(value);
            setState(() {});
          },
          children: [
            HomeView(),
            FavouriteView(),
          ],
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: vm.pageIndex,
          onTap: (value) {
            vm.pageController.animateToPage(value, duration: Duration(milliseconds: 100), curve: Curves.linear);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border)),
          ],
        ));
  }
}
