import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final int duration;

  const CustomLoader({Key key, this.duration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SpinKitFoldingCube(
          duration: Duration(seconds: duration ?? 3),
          size: 56.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
