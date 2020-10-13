import 'package:flutter/material.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
    @required this.press,
    this.text,
  }) : super(key: key);

  final Function press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: this.press,
          child: Text(
            this.text ?? '',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
