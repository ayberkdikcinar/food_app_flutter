import 'package:flutter/material.dart';
import '../extension/context_extension.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final String? imageURL;
  final bool star;
  final Widget? icon;

  const CustomCard({
    Key? key,
    this.title,
    this.imageURL = '',
    this.star = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            star == true
                ? Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        icon ?? Container(),
                      ],
                    ),
                  )
                : Container(),
            Expanded(flex: 6, child: buildPaddingImage(context)),
            Expanded(flex: 2, child: buildPaddingTitle(context)),
          ],
        ));
  }

  Padding buildPaddingTitle(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Center(
          child: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
      )),
    );
  }

  Padding buildPaddingImage(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Image.network(
        imageURL ?? '',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
