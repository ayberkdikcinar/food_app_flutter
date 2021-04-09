import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/base/base_statefull.dart';
import '../../core/components/custom_card.dart';
import '../../core/extension/context_extension.dart';
import '../../core/localization/strings.dart';
import '../../model/meal_detail_model.dart';
import '../product_viewmodel.dart';
import 'product_detail_view.dart';

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
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetailView(
                    /// pressed meal id to pass next page.
                    productId: _currentMeal?.idMeal,
                    icon: Icons.star_rounded, //this was for transmit icon state to navigated page.
                  ),
                ));
              },
              child: Container(
                height: dynamicHeight(0.35),
                child: buildCustomCard(_currentMeal!, productViewModel),
              ),
            ),
          );
        });
  }

  CustomCard buildCustomCard(MealDetail _currentMeal, ProductViewModel productViewModel) {
    return CustomCard(
      icon: IconButton(
        icon: Icon(Icons.star_rounded),
        color: theme.hoverColor,
        onPressed: () {
          productViewModel.deleteFromFavourite(_currentMeal.idMeal!);
        },
      ),
      imageURL: _currentMeal.strMealThumb,
      star: true,
      title: _currentMeal.strMeal,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Center(
      child: Text(
        ApplicationStrings.instance?.favourites ?? '',
        style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
      ),
    ));
  }
}
