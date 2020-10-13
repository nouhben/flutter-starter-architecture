import 'package:chatt_squad/components/custom_loader.dart';
import 'package:chatt_squad/screens/wrapper.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = false;
  Future<void> _load(BuildContext context) async {
    print('start to load..');
    Future.delayed(Duration(seconds: 8)).then((value) {
      print('end to load..');
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CustomLoader(duration: 3) : AuthWrapper();
  }
}
