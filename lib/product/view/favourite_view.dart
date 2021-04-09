import 'package:flutter/material.dart';
import 'package:food/core/base/base_statefull.dart';
import 'package:food/core/components/custom_card.dart';
import 'package:food/core/extension/context_extension.dart';
import 'package:food/core/localization/strings.dart';
import 'package:provider/provider.dart';

import '../product_viewmodel.dart';

class FavouriteView extends StatefulWidget {
  FavouriteView({Key? key}) : super(key: key);

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends StatefullBase<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    var productViewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: buildAppBar(),
      body: productViewModel.favMealList!.isEmpty
          ? FutureBuilder<bool>(
              future: productViewModel.getList(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.data!) {
                  return Center(
                    child: Text(
                      ApplicationStrings.instance!.youhaveNoFavourite,
                      style: theme.textTheme.headline5,
                    ),
                  );
                } else {
                  return buildListView(productViewModel);
                }
              },
            )
          : buildListView(productViewModel),
    );
  }

  ListView buildListView(ProductViewModel productViewModel) {
    return ListView.builder(
        itemCount: productViewModel.favMealList?.length, //snapshot.data?.length,
        itemBuilder: (context, index) {
          var _currentMeal = productViewModel.favMealList?[index];
          return Padding(
            padding: context.paddingLow,
            child: Container(
              height: dynamicHeight(0.35),
              child: CustomCard(
                icon: IconButton(
                  icon: Icon(Icons.star_rounded),
                  color: theme.hoverColor,
                  onPressed: () {
                    if (_currentMeal != null) {
                      productViewModel.deleteFromFavourite(_currentMeal.idMeal!);
                    }
                  },
                ),
                imageURL: _currentMeal?.strMealThumb,
                star: true,
                title: _currentMeal?.strMeal,
              ),
            ),
          );
        });
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Text(
      ApplicationStrings.instance?.favourites ?? '',
      style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
    ));
  }
}
