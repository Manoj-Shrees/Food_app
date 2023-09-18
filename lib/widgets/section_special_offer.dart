import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/restarunt_provider.dart';
import 'package:food_app/widgets/card_special_offer.dart';
import 'package:food_app/widgets/dialog_quantity.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class SpecialOfferSection extends StatelessWidget {
  const SpecialOfferSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var resturantProvider = Provider.of<RestaurantProvider>(
      context,
      listen: false,
    );
    return FutureBuilder(
      future: resturantProvider.fetchAndSetResturant(
        RestaurantFetchType.special,
      ),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          List<FoodItem> foodItems = snapshot.data as List<FoodItem>;
          return foodItems.length == 0
              ? Center(child: Text("No items found"))
              : Container(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    itemBuilder: (ctx, index) {
                      FoodItem foodItem = foodItems[index];
                      var auth = Provider.of<AuthProvider>(context);
                      return SpecialOfferCard(
                        image: foodItem.picUrl!,
                        itemName: foodItem.name!,
                        restaurantName: foodItem.restaurantName!,
                        category: foodItem.crusineType!,
                        addButtonHandler: () {
                          if (auth.user.isLoggedIn) {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return QuantityPickerDialog(
                                    foodItem: foodItem,
                                  );
                                });
                            // cartProvider.addItemToCart(foodItem, 1);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please Login to add items to cart.",
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                    itemCount: foodItems.length,
                    shrinkWrap: true,
                  ),
                );
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
