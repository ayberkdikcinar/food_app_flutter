import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/base/base_statefull.dart';
import '../core/components/custom_card.dart';
import '../core/extension/context_extension.dart';
import '../core/localization/strings.dart';
import '../model/area_model.dart';
import '../model/category_model.dart';
import '../product/view/product_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends StatefullBase<HomeView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final _homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: _homeViewModel.viewState == ViewState.Busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                buildPaddingAreaList(),
                buildGridViewCategory(),
              ],
            ),
    );
  }

  Padding buildPaddingAreaList() {
    final _homeViewModel = Provider.of<HomeViewModel>(context);
    return Padding(
      padding: context.paddingNormalVertical,
      child: Container(
          height: dynamicHeight(0.12),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _homeViewModel.areaList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductView(
                      nameValue: _homeViewModel.areaList[index].strArea,
                      categOrArea: false,
                    ),
                  ));
                },
                child: SizedBox(
                  width: dynamicWidth(0.4),
                  child: cardForAreas(_homeViewModel.areaList, index),
                ),
              );
            },
          )),
    );
  }

  GridView buildGridViewCategory() {
    final _homeViewModel = Provider.of<HomeViewModel>(context);
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      children: List.generate(_homeViewModel.categoryList.length, (index) {
        return Padding(
          padding: context.paddingLow,
          child: buildInkWell(_homeViewModel.categoryList, index),
        );
      }),
    );
  }

  InkWell buildInkWell(List<Category> snapshot, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductView(
            nameValue: snapshot[index].strCategory,
            categOrArea: true,
          ),
        ));
      },
      child: CustomCard(
        title: snapshot[index].strCategory,
        imageURL: snapshot[index].strCategoryThumb,
      ),
    );
  }

  Card cardForAreas(List<Area> snapshot, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: theme.canvasColor,
      child: Center(
          child: Text(
        snapshot[index].strArea!,
        style: theme.textTheme.bodyText1!.copyWith(),
      )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Center(
        child: Text(
          ApplicationStrings.instance!.homepage,
          style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
