import 'package:flutter/material.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/screens/address_search.dart';
import 'package:food_app/screens/login.dart';
import 'package:food_app/screens/signup.dart';
import 'package:food_app/util/images.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../screens/account.dart';
import '../screens/location.dart';
import '../screens/notification.dart';
import 'badge.dart';
import 'search_bar.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(130);
}

class _TopBarState extends State<TopBar> {
  ImageProvider<Object>? _buildAvatarImage(User user) {
    if (user.avatarUrl != null) {
      if (user.avatarUrl!.contains("http")) {
        return NetworkImage(user.avatarUrl!);
      }
      return AssetImage(user.avatarUrl!);
    }
    return AssetImage("assets/images/avatar_default.png");
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    User user = auth.user;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: 16,
        left: 16,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (user.isLoggedIn) {
                    Navigator.of(context).pushNamed(AccountScreen.ROUTE_NAME);
                  } else {
                    Navigator.of(context).pushNamed(LoginScreen.ROUTE_NAME);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    foregroundImage: Images.buildAvatarImage(user),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSearch(context: context, delegate: AddressSearch());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivered to"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "87 Ocean Street, Westmead",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),

              ),
            ],
          ),
          SizedBox(height: 5),
          Searchbar(),
        ],
      ),
    );
  }
}
