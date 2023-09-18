import 'package:flutter/material.dart';
import 'package:food_app/pages/cart.dart';
import 'package:food_app/pages/categories.dart';
import 'package:food_app/pages/home.dart';
import 'package:food_app/pages/orders.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/widgets/badge.dart';
import 'package:food_app/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE_NAME = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    CategoriesPage(),
    CartPage(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 5,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).backgroundColor,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(
              builder: (ctx, cartProvider, child) {
                if (cartProvider.cartItems != null) {

                }
                return child!;
              },
              child: Icon(Icons.shopping_cart),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: "Orders",
          ),
        ],
      ),
    );
  }
}
