import 'package:chatt_squad/components/custom_loader.dart';
import 'package:chatt_squad/components/form_errors.dart';
import 'package:chatt_squad/services/authentication_service.dart';
import 'package:chatt_squad/shared/constants.dart';
import 'package:chatt_squad/shared/size_config.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String email;
  String fullName;
  String password;
  bool rememberMe = false;
  List<String> errors = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CustomLoader()
        : Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.79,
                  child: _buildFullNameFormField(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.79,
                  child: _buildEmailFormField(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.79,
                  child: _buildPasswordFormField(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(30)),
                RaisedButton(
                  color: kPrimaryColor,
                  child: Text('Sign up'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      dynamic user =
                          await _authService.registerWithEmailAndPassword(
                        email: this.email,
                        password: this.password,
                      );
                      print(user);
                      if (user == null) {
                        setState(() {
                          this.errors = [];
                          this.errors.add('Could not sign up please checkout');
                          isLoading = false;
                        });
                      }
                      //}
                    }
                  },
                ),
              ],
            ),
          );
  }

  TextFormField _buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        setState(() => email = value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return kEmailNullError;
        }
        if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email),
      ),
    );
  }

  TextFormField _buildFullNameFormField() {
    return TextFormField(
      onSaved: (newValue) => fullName = newValue,
      onChanged: (value) {
        setState(() => fullName = value);
      },
      validator: (value) {
        return value.length < 5 ? kshortNameError : null;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Enter your full name',
        labelText: "Full name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField _buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        setState(() => password = value);
      },
      validator: (value) {
        return value.length < 8 ? kshortPassError : null;
      },
      decoration: InputDecoration(
        hintText: 'Enter your password',
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
      ),
    );
  }
}
