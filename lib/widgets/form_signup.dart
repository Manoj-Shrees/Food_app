import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/screens/loading.dart';
import 'package:food_app/screens/login.dart';
import 'package:food_app/util/dialogs.dart';
import 'package:food_app/util/strings.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'button_rounded.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = UniqueKey();
  final _confirmPasswordKey = UniqueKey();
  final _emailKey = UniqueKey();
  final _phoneKey = UniqueKey();
  final _firstNameKey = UniqueKey();
  final _lastNameKey = UniqueKey();

  final _passwordInputController = TextEditingController();
  final _confirmPasswordInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _phoneInputController = TextEditingController();
  final _firstNameInputController = TextEditingController();
  final _lastNameInputController = TextEditingController();

  int _pageIndex = 0;

  List<Widget> _getPageContent(int index) {
    switch (index) {
      case 0:
        return _getPageOne();
      case 1:
        return _getPageTwo();
      case 2:
        return _getPageThree();
      default:
        return [CircularProgressIndicator()];
    }
  }

  List<Widget> _getPageOne() {
    return [
      TextFormField(
        key: _phoneKey,
        controller: _phoneInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(hintText: "Phone"),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onSaved: (phone) {},
        validator: (phone) {
          if (phone!.isEmpty) return "Please enter your phone number.";
          if (!phone.contains(RegExp(Strings.PHONE_PATTERN)))
            return "Please enter a valid phone number";
          return null;
        },
      ),
      TextFormField(
        key: _emailKey,
        controller: _emailInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(hintText: "Email"),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onSaved: (email) {},
        validator: (email) {
          if (email!.isEmpty) return "Please enter your email";
          if (!email.contains(RegExp(Strings.EMAIL_PATTERN)))
            return "Please enter a valid email.";
          return null;
        },
      ),
    ];
  }

  List<Widget> _getPageTwo() {
    return [
      TextFormField(
        key: _passwordKey,
        controller: _passwordInputController,
        decoration: const InputDecoration(hintText: "Create Password"),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onSaved: (password) {},
        onFieldSubmitted: (_) {},
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (password) {
          if (password!.isEmpty) return "Please enter your password!";
          if (password.length < 6) return "Invalid password length";
          return null;
        },
      ),
      TextFormField(
        key: _confirmPasswordKey,
        controller: _confirmPasswordInputController,
        decoration: const InputDecoration(hintText: "Confirm Password"),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onSaved: (confirmPassword) {},
        onFieldSubmitted: (_) {},
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (confirmPassword) {
          if (confirmPassword!.isEmpty) return "Please enter your password!";
          if (confirmPassword.length < 6) return "Invalid password length";
          if (_passwordInputController.text != confirmPassword)
            return "Password didn't match";
          return null;
        },
      )
    ];
  }

  List<Widget> _getPageThree() {
    return [
      TextFormField(
        key: _firstNameKey,
        controller: _firstNameInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(hintText: "First Name"),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onSaved: (firstName) {},
        validator: (firstName) {
          if (firstName!.isEmpty) return "Please enter your first name";
          if (firstName.length < 2) return "Must be more than 2 characters";
          return null;
        },
      ),
      TextFormField(
        key: _lastNameKey,
        controller: _lastNameInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(hintText: "Last Name"),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onSaved: (lastName) {},
        validator: (lastName) {
          if (lastName!.isEmpty) return "Please enter your last name";
          if (lastName.length < 2) return "Must be more than 2 characters";
          return null;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              ..._getPageContent(_pageIndex),
              SizedBox(height: 25),
              RoundedButton(
                text: _pageIndex >= 2 ? "FINISH" : "CONTINUE",
                onPressed: () {
                  if (_pageIndex == 2) {
                    Navigator.of(context).push(LodaingOverlay());

                    var auth = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );

                    var authFuture = auth.signup(
                      phone: _phoneInputController.text,
                      email: _emailInputController.text,
                      password: _passwordInputController.text,
                      firstName: _firstNameInputController.text,
                      lastName: _lastNameInputController.text,
                    );

                    authFuture.then((message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(
                        LoginScreen.ROUTE_NAME,
                      );
                    }).catchError((response) {
                      Navigator.of(context).pop();
                    });
                  }
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      if (_pageIndex < 2) {
                        _pageIndex++;
                      } else {
                        _pageIndex = 2;
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
