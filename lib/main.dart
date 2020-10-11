import 'package:chatt_squad/models/my_theme_provider.dart';
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
          home: MultiProvider(providers: [
            ChangeNotifierProvider<Counter>(create: (context) => Counter()),
            ChangeNotifierProvider<ValueNotifier<int>>(
              create: (context) => ValueNotifier<int>(0),
            ),
          ], child: MyHomePage(title: 'Flutter Base')),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);
    //we get the counter object created & also register as listener
    print('re-building');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<ValueNotifier<int>>(
              builder: (_, value, __) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Text(
              'and you have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (_, myCounter, __) => Text(
                '${myCounter.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                //myCounter.increment();
                counter.value++;
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.value++;
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int count = 0;
  void increment() {
    count++;
    notifyListeners();
  }
}
