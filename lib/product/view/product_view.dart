import 'package:flutter/material.dart';
import 'package:food/core/base/base_statefull.dart';
import 'package:food/core/components/star_widget.dart';
import 'package:food/core/extension/context_extension.dart';
import 'package:food/product/product_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../core/components/custom_card.dart';
import '../../core/localization/strings.dart';
import '../../model/meal_detail_model.dart';
import '../../services/api_service.dart';
import 'product_detail_view.dart';

class ProductView extends StatefulWidget {
  ProductView({Key? key, required this.categoryName, this.categOrArea}) : super(key: key);
  final categoryName;
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
    return FutureBuilder<List<MealDetail>>(
      future: widget.categOrArea == true ? ApiService().getMealListByCategoryName(widget.categoryName) : ApiService().getMealListByArea(widget.categoryName),
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
    var productViewModel = Provider.of<ProductViewModel>(context, listen: false);

    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailView(
              productId: _recentMeal.idMeal,
              icon: icon,
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
      widget.categoryName,
      style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
    ));
  }
}
