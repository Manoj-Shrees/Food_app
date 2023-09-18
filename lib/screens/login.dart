import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/form_login.dart';
import '../screens/signup.dart';
import '../widgets/button_close_circular.dart';
import '../util/dimen.dart';
import '../widgets/button_sbs.dart';

class LoginScreen extends StatefulWidget {
  static const String ROUTE_NAME = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginFormType _loginInputFieldsType = LoginFormType.email;
  bool _leftChildDisabled = true;
  bool _rightChildDisabled = false;

  final _formPhoneKey = GlobalKey<FormState>();
  final _formEmailKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: ListView(
                padding: EdgeInsets.all(Dimention.thickBorder),
                shrinkWrap: true,
                children: [
                  SBSButtons(
                    context: context,
                    leftChild: SBSButtonChild(
                      Icon(Icons.email),
                      "Email",
                      disabled: _leftChildDisabled,
                    ),
                    rightChild: SBSButtonChild(
                      Icon(Icons.phone),
                      "Phone",
                      disabled: _rightChildDisabled,
                    ),
                    type: SBSButtonType.elevated,
                    color: SBSButtonColor.accent,
                    leftHandler: () {
                      setState(() {
                        _loginInputFieldsType = LoginFormType.email;
                        _leftChildDisabled = true;
                        _rightChildDisabled = false;
                      });
                    },
                    rightHandler: () {
                      setState(() {
                        _loginInputFieldsType = LoginFormType.phone;
                        _leftChildDisabled = false;
                        _rightChildDisabled = true;
                      });
                    },
                  ),
                  SizedBox(height: 50),
                  LoginForm(
                    formEmailKey: _formEmailKey,
                    formPhoneKey: _formPhoneKey,
                    type: _loginInputFieldsType,
                  ),
                  SizedBox(height: 70),
                  SBSButtons(
                    context: context,
                    leftChild: SBSButtonChild(
                      Image.asset(
                        "assets/icons/f_logo_RGB-Blue_58.png",
                        width: 30,
                      ),
                      "Facebook",
                    ),
                    rightChild: SBSButtonChild(
                      SvgPicture.asset("assets/icons/Google__G__Logo.svg"),
                      "Google",
                    ),
                    type: SBSButtonType.outlined,
                    rightHandler: () {},
                    leftHandler: () {},
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Not registered yet?",
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              SignUpScreen.ROUTE_NAME,
                            );
                          },
                          child: Text("Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CircularCloseButton(),
          ],
        ),
      ),
    );
  }
}
