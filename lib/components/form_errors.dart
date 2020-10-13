import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required List<String> errors,
  })  : _errors = errors,
        super(key: key);

  final List<String> _errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        _errors.length,
        (index) => buildFormErrorText(text: _errors[index]),
      ),
    );
  }

  Row buildFormErrorText({String text}) {
    return Row(
      children: [
        Icon(Icons.clear, size: 16.0, color: Colors.red),
        SizedBox(width: 10.0),
        Text(text),
      ],
    );
  }
}
