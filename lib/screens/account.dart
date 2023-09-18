import 'package:flutter/material.dart';
import 'package:food_app/models/user.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/util/dialogs.dart';
import 'package:food_app/util/images.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/account";

  const AccountScreen({Key? key}) : super(key: key);
  Widget _listItemBuilder({
    IconData? icon,
    required String title,
    TextStyle? style,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: style!.color,
              ),
              SizedBox(width: 15),
            ],
            Text(
              title,
              style: style,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var headline2 = Theme.of(context).textTheme.headline3;
    var authProvider = Provider.of<AuthProvider>(context);
    User user = authProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  minRadius: 40,
                  backgroundImage: Images.buildAvatarImage(user),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "${user.email}",
                      style: headline2,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 1),
            Expanded(
              child: ListView(
                children: [
                  _listItemBuilder(
                    icon: Icons.person_outline_rounded,
                    title: "My Details",
                    style: headline2,
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  _listItemBuilder(
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Payment Methods",
                    style: headline2,
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  _listItemBuilder(
                    icon: Icons.location_on_outlined,
                    title: "Manage Address",
                    style: headline2,
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  _listItemBuilder(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    style: headline2,
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  Divider(thickness: 1),
                  _listItemBuilder(
                    title: "Terms & Conditions",
                    style: headline2!.copyWith(fontSize: 17),
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  _listItemBuilder(
                    title: "FAQ",
                    style: headline2.copyWith(fontSize: 17),
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  _listItemBuilder(
                    title: "Privacy Policy",
                    style: headline2.copyWith(fontSize: 17),
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  _listItemBuilder(
                    title: "Help & Support",
                    style: headline2.copyWith(fontSize: 17),
                    onTap: () => Dialogs.featureInProgress(context),
                  ),
                  Divider(thickness: 1),
                  _listItemBuilder(
                    icon: Icons.logout_rounded,
                    title: "Logout",
                    style: headline2.copyWith(color: Colors.red),
                    onTap: () {
                      Navigator.of(context).pop();
                      authProvider.logout().then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Logout Successful.",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
