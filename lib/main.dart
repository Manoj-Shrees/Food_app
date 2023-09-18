import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/category_provider.dart';
import 'package:food_app/providers/geolocator_provider.dart';
import 'package:food_app/providers/restarunt_provider.dart';
import 'package:provider/provider.dart';

import '/screens/account.dart';
import '/screens/home.dart';
import '/screens/location.dart';
import '/screens/login.dart';
import '/screens/search.dart';
import '/screens/signup.dart';
import '/util/colours.dart';
import '/screens/notification.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(),
        ),
        ChangeNotifierProvider<GeolocatorProvider>(
          create: (BuildContext context) => GeolocatorProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CartProvider>(create: (ctx) {
          print("Created...");
          return CartProvider();
        }, update: (ctx, auth, old) {
          print("Update...");
          return CartProvider(auth: auth, cartItems: old!.cartItems);
        }),
        ChangeNotifierProxyProvider2<AuthProvider, GeolocatorProvider,
            RestaurantProvider>(
          create: (ctx) {
            return RestaurantProvider();
          },
          update: (ctx, auth, geo, old) {
            if (old != null) {
              return RestaurantProvider(
                auth: auth,
                recommemdedRestaurants: old.recommemdedRestaurants,
                geolocatorProvider: geo,
                topRestaurants: old.topRestaurants,
              );
            }
            return RestaurantProvider();
          },
        ),
        ChangeNotifierProvider<CategoryProvider>(create: (ctx) {
          return CategoryProvider(categories: []);
        })
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actionsIconTheme: IconThemeData(color: Colours.TEXT_COLOR),
          iconTheme: IconThemeData(color: Colours.TEXT_COLOR), systemOverlayStyle: SystemUiOverlayStyle.dark, toolbarTextStyle: Theme.of(context).textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 18,
                  color: Colours.TEXT_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ).bodyText2, titleTextStyle: Theme.of(context).textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: 18,
                  color: Colours.TEXT_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ).headline6,
        ),
        iconTheme: IconThemeData(color: Colours.accent),
        primarySwatch: Colours.primarySwatch,
        hintColor: Colours.accent,
        canvasColor: Colours.background,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 23,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            color: Colours.TEXT_COLOR,
          ),
          headline2: TextStyle(
            fontSize: 20,
            color: Colours.TEXT_COLOR,
          ),
          headline3: TextStyle(
            fontSize: 17,
            color: Colours.TEXT_COLOR,
          ),
          headline4: TextStyle(
            fontSize: 15,
            color: Colours.TEXT_COLOR,
          ),
        ),
      ),
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
        SignUpScreen.ROUTE_NAME: (context) => SignUpScreen(),
        LoginScreen.ROUTE_NAME: (context) => LoginScreen(),
        AccountScreen.ROUTE_NAME: (context) => AccountScreen(),
        NotificationScreen.ROUTE_NAME: (context) => NotificationScreen(),
        SearchScreen.ROUTE_NAME: (context) => SearchScreen(),
        LocationScreen.ROUTE_NAME: (context) => LocationScreen(),
      },
    );
  }
}
