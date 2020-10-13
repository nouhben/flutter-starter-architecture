import 'package:chatt_squad/models/custom_user.dart';
import 'package:chatt_squad/models/my_theme_provider.dart';
import 'package:chatt_squad/screens/loading.dart';
import 'package:chatt_squad/services/authentication_service.dart';
import 'package:chatt_squad/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('Loading from here...');
    return ChangeNotifierProvider<MyThemeModel>(
      create: (context) => MyThemeModel(),
      child: Consumer<MyThemeModel>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Base App Structure',
          theme: themeData(context),
          darkTheme: darkThemeData(context),
          themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          home: StreamProvider<CustomUser>(
            create: (context) => AuthService().user,
            child: LoadingScreen(),
          ),
        ),
      ),
    );
  }
}
