import 'package:chatt_squad/components/no_account_text.dart';
import 'package:chatt_squad/screens/authentication/components/sign_in/sign_in_form.dart';
import 'package:chatt_squad/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _showSignUp = Provider.of<ValueNotifier<bool>>(
      context,
      listen: false,
    );
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        actions: [
          MaterialButton(
            child: Row(
              children: [
                Text('Sign up'),
                Icon(Icons.person, color: Colors.black),
              ],
            ),
            onPressed: () {
              _showSignUp.value = !_showSignUp.value;
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(28),
                    ),
                  ),
                  Text(
                    'Sign in with email and password',
                    textAlign: TextAlign.center,
                  ),
                  //SizeConfig.screenHeight * 0.08
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignInForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  NoAccountText(
                    text: 'Don\'t have an account?',
                    press: () {
                      _showSignUp.value = !_showSignUp.value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
