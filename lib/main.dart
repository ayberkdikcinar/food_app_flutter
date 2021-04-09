import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_bar/default_tab_view.dart';
import 'bottom_bar/default_tab_viewmodel.dart';
import 'core/theme/light_theme.dart';
import 'home/home_viewmodel.dart';
import 'product/product_viewmodel.dart';
import 'services/db_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavouritesDatabaseProvider.instance?.open();
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
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      home: DefaulTabView(),
      theme: LightTheme.instance!.data,
    );
  }
}
