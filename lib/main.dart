import 'package:flutter/material.dart';
import 'package:food/bottom_bar/default_tab_viewmodel.dart';
import 'package:food/home/home_viewmodel.dart';
import 'package:food/product/product_viewmodel.dart';
import 'package:food/services/db_service.dart';
import 'package:food/bottom_bar/default_tab_view.dart';
import 'package:provider/provider.dart';

import 'core/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavouritesDatabaseProvider().open();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeViewModel()),
    ChangeNotifierProvider(create: (context) => ProductViewModel()),
    ChangeNotifierProvider(create: (context) => DefaultTabVM()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: DefaulTabView(),
      theme: LightTheme.instance!.data,
    );
  }
}
