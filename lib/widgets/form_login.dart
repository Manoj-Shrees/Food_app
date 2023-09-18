import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/screens/loading.dart';
import 'package:food_app/util/dialogs.dart';
import 'package:food_app/util/strings.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

import 'button_rounded.dart';

enum LoginFormType { email, phone }

class LoginForm extends StatelessWidget {
  final LoginFormType type;

  final GlobalKey<FormState>? formPhoneKey;
  final GlobalKey<FormState>? formEmailKey;

  LoginForm({
    this.formEmailKey,
    this.formPhoneKey,
    this.type = LoginFormType.email,
    Key? key,
  }) : super(key: key);
  final _customer = User();

  final passwordInputController = TextEditingController();

  final emailInputController = TextEditingController();

  final phoneInputController = TextEditingController();

  TextFormField _passwordInputBuilder(BuildContext context) {
    return TextFormField(
      controller: passwordInputController,
      decoration: const InputDecoration(hintText: "Password"),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onSaved: (password) {
        _customer.password = password;
      },
      onFieldSubmitted: (_) {
        _formSubmit(context);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (password) {
        if (password!.isEmpty) return "Please enter your password!";
        if (password.length < 6) return "Invalid password length";
        return null;
      },
    );
  }

  void _formSubmit(BuildContext context) {
    switch (type) {
      case LoginFormType.email:
        if (formEmailKey!.currentState!.validate()) {
          formEmailKey!.currentState!.save();
          _authenticate(
            context,
            emailInputController.text.toLowerCase(),
            passwordInputController.text,
          );
        }
        break;
      case LoginFormType.phone:
        if (formPhoneKey!.currentState!.validate()) {
          formPhoneKey!.currentState!.save();
          _authenticate(
            context,
            phoneInputController.text,
            passwordInputController.text.trim(),
          );
        }
        break;
    }
  }

  void _authenticate(BuildContext context, String username, String password) {
    Navigator.of(context).push(LodaingOverlay());
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider.authenticate(username, password).then(
      (user) {
        authProvider.user = user as User;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Welcome ${user.firstName} ${user.lastName}",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    ).catchError(
      (error) {
        Navigator.of(context).pop();
        Dialogs.loginFailed(context, error);
      },
    );
  }

  Widget _loginButtonBuilder(BuildContext context) {
    return RoundedButton(
      text: "LOGIN",
      onPressed: () {
        _formSubmit(context);
      },
    );
  }

  Widget _forgotPasswordButtonBuilder() {
    return Container(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {},
        child: Text("Forgot Password?"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (this.type) {
      case LoginFormType.phone:
        return Form(
          key: formPhoneKey,
          child: Column(
            children: [
              TextFormField(
                controller: phoneInputController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(hintText: "Phone"),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onSaved: (phone) {
                  _customer.phone = phone;
                },
                validator: (phone) {
                  if (phone!.isEmpty) return "Please enter your phone number.";
                  if (!phone.contains(RegExp(Strings.PHONE_PATTERN)))
                    return "Please enter a valid phone number";
                  return null;
                },
              ),
              _passwordInputBuilder(context),
              _forgotPasswordButtonBuilder(),
              _loginButtonBuilder(context),
            ],
          ),
        );
      case LoginFormType.email:
      default:
        return Form(
          key: formEmailKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailInputController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSaved: (email) {
                  _customer.email = email;
                },
                validator: (email) {
                  if (email!.isEmpty) return "Please enter your email";
                  if (!email.contains(RegExp(Strings.EMAIL_PATTERN)))
                    return "Please enter a valid email.";
                  return null;
                },
              ),
              _passwordInputBuilder(context),
              _forgotPasswordButtonBuilder(),
              _loginButtonBuilder(context),
            ],
          ),
        );
    }
  }
}
