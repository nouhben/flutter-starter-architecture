import 'package:chatt_squad/components/custom_loader.dart';
import 'package:chatt_squad/components/form_errors.dart';
import 'package:chatt_squad/services/authentication_service.dart';
import 'package:chatt_squad/shared/constants.dart';
import 'package:chatt_squad/shared/size_config.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  String email;
  String password;
  List<String> errors = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isLoading
        ? CustomLoader()
        : Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.79,
                  child: buildEmailFormField(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.79,
                  child: buildPasswordFormField(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                      },
                      padding: EdgeInsets.only(left: 36),
                      child: Text(
                        'Forget Password',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(30)),
                RaisedButton(
                  color: kPrimaryColor,
                  child: Text('Sign in'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      dynamic user =
                          await _authService.signInWithEmailAndPassword(
                        email: this.email,
                        password: this.password,
                      );
                      print(user);
                      if (user == null) {
                        setState(() {
                          this.errors = [];
                          this.errors.add('Could not sign in please checkout');
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      // validator: (val) => (val.isEmpty || val.length < 6) ? return 'invalid value' : return null,
      onFieldSubmitted: (value) {
        setState(() {
          email = value;
        });
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      onFieldSubmitted: (value) {
        setState(() {
          password = value;
        });
      },
      validator: (value) {
        if (value.length < 8) return kshortPassError;
        return null;
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
