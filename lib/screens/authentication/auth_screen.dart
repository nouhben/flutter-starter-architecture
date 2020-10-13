import 'package:chatt_squad/screens/authentication/components/sign_in/sign_in.dart';
import 'package:chatt_squad/screens/authentication/components/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _showSignIn = Provider.of<ValueNotifier<bool>>(context);
    return _showSignIn.value ? SignInScreen() : SignUpScreen();
  }
}
