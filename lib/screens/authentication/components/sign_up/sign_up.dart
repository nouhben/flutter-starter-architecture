import 'package:chatt_squad/components/no_account_text.dart';
import 'package:chatt_squad/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _showSignIn = Provider.of<ValueNotifier<bool>>(
      context,
      listen: false,
    );
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: [
          MaterialButton(
            child: Row(
              children: [
                Text('Sign In'),
                Icon(Icons.person, color: Colors.black),
              ],
            ),
            onPressed: () {
              _showSignIn.value = !_showSignIn.value;
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
                    'Welcome',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(28),
                    ),
                  ),
                  Text(
                    'Sign up with email and password\nand provide your full name',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignUpForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  NoAccountText(
                    text: 'Already have an account?',
                    press: () {
                      _showSignIn.value = !_showSignIn.value;
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
