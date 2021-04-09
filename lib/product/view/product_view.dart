import 'package:flutter/material.dart';
import '../../core/base/base_statefull.dart';
import '../../core/components/star_widget.dart';
import '../../core/extension/context_extension.dart';
import '../product_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../core/components/custom_card.dart';
import '../../core/localization/strings.dart';
import '../../model/meal_detail_model.dart';
import 'product_detail_view.dart';

class ProductView extends StatefulWidget {
  ProductView({Key? key, required this.nameValue, this.categOrArea}) : super(key: key);
  final nameValue;
  final categOrArea;
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends StatefullBase<ProductView> with AutomaticKeepAliveClientMixin {
  IconData icon = Icons.star_border; //this was for transmit icon state to navigated page.

  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildFutureBuilder(),
    );
  }

  FutureBuilder<List<MealDetail>> buildFutureBuilder() {
    final productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    return FutureBuilder<List<MealDetail>>(
      future: widget.categOrArea == true ? productViewModel.getMealListByCategoryName(widget.nameValue) : productViewModel.getMealListByArea(widget.nameValue),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return futureBodyGridView(snapshot);
      },
    );
  }

  GridView futureBodyGridView(AsyncSnapshot<List<MealDetail>> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2 / 3.5,
      padding: context.paddingLow,
      children: List.generate(snapshot.data!.length, (index) {
        var _recentMeal = snapshot.data![index];
        return buildInkWell(_recentMeal);
      }),
    );
  }

  InkWell buildInkWell(MealDetail _recentMeal) {
    final productViewModel = Provider.of<ProductViewModel>(context, listen: false);

    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailView(
              /// pressed meal id to pass next page.
              productId: _recentMeal.idMeal,
              icon: icon, //this was for transmit icon state to navigated page.
            ),
          ));
        },
        child: FutureBuilder<bool>(
          future: productViewModel.searchListById(_recentMeal.idMeal!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomCard(
              icon: StarWidget(
                onStarTap: (val) async {
                  //val is the last state of star icon.
                  if (val == false) {
                    //false means icon is black star, so recent meal is not in the favourites.
                    icon = Icons.star_rounded;
                    await productViewModel.addToFavourite(_recentMeal);
                    ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(text: ApplicationStrings.instance?.hasAdded ?? '', bgColor: theme.hintColor));
                  } else {
                    /// true state. recent meal has already in the favourites.
                    icon = Icons.star_border;
                    await productViewModel.deleteFromFavourite(_recentMeal.idMeal!);
                    ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(text: ApplicationStrings.instance?.hasDeleted ?? '', bgColor: theme.errorColor));
                  }
                },
                initState: snapshot.data,
              ),
              star: true, // star true means, card widget should has a star icon
              title: _recentMeal.strMeal,
              imageURL: _recentMeal.strMealThumb,
            );
          },
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
        title: Text(
      widget.nameValue,
      style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
    ));
  }
}
