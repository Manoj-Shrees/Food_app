import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/widgets/form_signup.dart';

import '../screens/login.dart';
import '../widgets/button_close_circular.dart';
import '../util/dimen.dart';
import '../widgets/button_sbs.dart';

class SignUpScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/signup";

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
                  SizedBox(height: 50),
                  SignupForm(),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              LoginScreen.ROUTE_NAME,
                            );
                          },
                          child: Text("Login"),
                        )
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
