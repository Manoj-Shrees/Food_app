import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/models/cart_item.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/util/strings.dart';

import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  late List<CartItem>? _cartItems;

  get cartItems {
    if (_cartItems != null) {
      return _cartItems;
    }
    fetchCartItems();
  }

  AuthProvider? auth;

  CartProvider({
    this.auth,
    List<CartItem>? cartItems,
  }) {
    _cartItems = cartItems;
  }

  Future<List<CartItem>> fetchCartItems() async {
    List<CartItem> cartItems = [];
    if (auth != null && auth!.isLoggedIn) {
      Map<String, String> params = {
        "Customer_id": auth!.user.userID!,
      };
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${auth!.token}",
      };
      var uri = Uri.https(
        Strings.domain,
        "api/v1/get_carts",
        params,
      );
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 401) {
        print(response.body);
        notifyListeners();
        return Future.error("User not Authenticated.");
      } else if (response.statusCode == 200) {
        print(response.statusCode);
        var extractedData = json.decode(response.body) as List<dynamic>;
        print(extractedData.length);
        extractedData.forEach(
          (element) {
            print(element);
            var cartItem = CartItem(
              id: int.parse(element['item_id']),
              title: element['name'],
              image: element['pic_url'],
              price: double.parse(element['price']),
              quantity: int.parse(element['quantity']),
            );
            cartItems.add(cartItem);
          },
        );
        notifyListeners();
        return _cartItems = cartItems;
      }
    }
    return _cartItems = cartItems;
  }

  Future addItemToCart(FoodItem foodItem, int quantaty) async {
    if (auth != null) {
      Map<String, String> params = {
        "Item_id": foodItem.id.toString(),
        "Customer_id": auth!.user.userID!,
        "quantity": quantaty.toString(),
      };
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${auth!.token}",
      };
      var uri = Uri.https(
        Strings.domain,
        "api/v1/add_carts",
        params,
      );
      var response = await http.post(uri, headers: headers);
      if (response.statusCode == 201) {
        return Future.value("Success");
      }
      return Future.error("Cannot add item to cart.");
    }
    return Future.error("User not authenticated.");
  }
}
