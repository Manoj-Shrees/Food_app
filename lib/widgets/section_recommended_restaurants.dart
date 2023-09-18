import 'package:flutter/material.dart';
import 'package:food_app/models/restaurant.dart';
import 'package:food_app/providers/restarunt_provider.dart';
import 'package:provider/provider.dart';

import 'card_restaurants.dart';

class RecommendedRestaurantSection extends StatelessWidget {
  const RecommendedRestaurantSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var resturantProvider = Provider.of<RestaurantProvider>(
      context,
      listen: false,
    );
    return FutureBuilder(
      future: resturantProvider.fetchAndSetResturant(
        RestaurantFetchType.recommended,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> restaurants = snapshot.data as List<Restaurant>;
          return restaurants.length == 0
              ? Center(child: Text("No Items Found"))
              : Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    shrinkWrap: true,
                    itemCount: restaurants.length,
                    itemBuilder: (_, index) {
                      Restaurant restaurant = restaurants[index];
                      return RestaurantCard(
                        image: restaurant.profileUrl!,
                        title: restaurant.name!,
                        subtitle: restaurant.address!,
                      );
                    },
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
