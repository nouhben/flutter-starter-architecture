import 'package:chatt_squad/models/my_theme_provider.dart';
import 'package:chatt_squad/screens/loading.dart';
import 'package:chatt_squad/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyThemeModel>(
      create: (context) => MyThemeModel(),
      child: Consumer<MyThemeModel>(
        builder: (context, theme, child) => MaterialApp(
          title: 'Flutter Base App Structure',
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          home: LoadingScreen(),
        ),
      ),
    );
  }
}
