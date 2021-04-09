import 'package:flutter/material.dart';
import 'package:food/core/extension/context_extension.dart';

import '../../core/localization/strings.dart';
import '../../model/meal_detail_model.dart';
import '../../services/api_service.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({Key? key, required this.productId, required this.icon}) : super(key: key);
  final String? productId;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: buildPaddingMealDetail(context),
        ));
  }

  Padding buildPaddingMealDetail(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: FutureBuilder<List<MealDetail>>(
        future: ApiService().getMealDetailById(productId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return buildPaddingListColumns(context, snapshot, index);
            },
          );
        },
      ),
    );
  }

  Padding buildPaddingListColumns(BuildContext context, AsyncSnapshot<List<MealDetail>> snapshot, int index) {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        children: [
          Image.network(
            snapshot.data![index].strMealThumb!,
          ),
          buildColumnInListView(snapshot, index, context),
        ],
      ),
    );
  }

  Column buildColumnInListView(AsyncSnapshot<List<MealDetail>> snapshot, int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        emptySpace(),
        Text('Name: ' + snapshot.data![index].strCategory!, style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold)),
        emptySpace(),
        Text('Category: ' + snapshot.data![index].strMeal!, style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold)),
        emptySpace(),
        Text('Description:', style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold)),
        emptySpace(),
        Text(snapshot.data![index].strInstructions!),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        ApplicationStrings.instance!.productDetail,
        style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [Icon(icon, color: Theme.of(context).hoverColor)],
    );
  }

  SizedBox emptySpace() => SizedBox(height: 20);
}
