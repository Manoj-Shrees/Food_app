import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/models/restaurant.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/providers/geolocator_provider.dart';
import 'package:food_app/util/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum RestaurantFetchType {
  top,
  recommended,
  special,
}

class RestaurantProvider with ChangeNotifier {
  List<Restaurant>? recommemdedRestaurants = [];
  List<Restaurant>? topRestaurants = [];
  List<FoodItem>? specialOffer = [];
  AuthProvider? auth;
  GeolocatorProvider? geolocatorProvider;

  RestaurantProvider({
    this.recommemdedRestaurants,
    this.topRestaurants,
    this.specialOffer,
    this.auth,
    this.geolocatorProvider,
  }) {
    if (recommemdedRestaurants == null) {
      recommemdedRestaurants = [];
    }
    if (topRestaurants == null) {
      topRestaurants = [];
    }
    if (specialOffer == null) {
      specialOffer = [];
    }
  }
  List<Restaurant> _extractData(Response response) {
    List<Restaurant> restaurants = [];

    var extractedData = json.decode(response.body) as List<dynamic>;
    extractedData.forEach(
      (element) {
        var restaurant = Restaurant();
        restaurant.id = element['id'];
        restaurant.name = element['name'];
        restaurant.rating = double.parse(element['rating']);
        restaurant.ownerFirstName = element['owner_First_name'];
        restaurant.ownerLastName = element['owner_Last_name'];
        restaurant.address = element['address'];
        restaurant.profileUrl = element['profile_url'];
        restaurant.latitude = double.parse(element['latitude']);
        restaurant.longitude = double.parse(element['longitude']);
        restaurant.distance = double.parse(element['distance']);
        restaurants.add(restaurant);
      },
    );
    return restaurants;
  }

  List<FoodItem> _extractSpecialOfferData(Response response) {
    List<FoodItem> foodItems = [];

    var extractedData = json.decode(response.body) as List<dynamic>;
    extractedData.forEach(
      (element) {
        var foodItem = FoodItem(
          id: element['id'],
          name: element['name'],
          restaurantId: int.parse(element['Resturant_id']),
          price: double.parse(element['price']),
          discountPrice: double.parse(element['disc_price']),
          crusineType: element['cusine_type'],
          description: element['descrp'],
          rating: double.parse(element['rating']),
          restaurantName: element['Resturants_name'],
          picUrl: element['pic_url'],
          distance: double.parse(element['distance']),
        );
        foodItems.add(foodItem);
      },
    );
    return foodItems;
  }

  Future<dynamic> fetchAndSetResturant(
    RestaurantFetchType type,
  ) async {
    if (geolocatorProvider != null) {
      if (geolocatorProvider!.currentLocation != null) {
        await geolocatorProvider!.setCurrentLocaiton();
      }
      var params = {
        "latitude": "${geolocatorProvider!.currentLocation!.latitude}",
        "longitude": "${geolocatorProvider!.currentLocation!.longitude}",
      };
      // var params = {
      //   "latitude": "-33.931846",
      //   "longitude": "150.919726",
      // };
      var uri;
      if (type == RestaurantFetchType.recommended) {
        uri = Uri.https(
          Strings.domain,
          "/api/home/resturants_nearby",
          params,
        );
        recommemdedRestaurants!.clear();
        var response = await http.get(uri);
        return recommemdedRestaurants = _extractData(response);
      } else if (type == RestaurantFetchType.special) {
        uri = Uri.https(
          Strings.domain,
          "/api/home/items_specialoffers",
          params,
        );
        specialOffer!.clear();
        var response = await http.get(uri);
        return specialOffer = _extractSpecialOfferData(response);
      } else if (type == RestaurantFetchType.top) {
        uri = Uri.https(
          Strings.domain,
          "/api/home/top_resturants_nearby",
          params,
        );
        topRestaurants!.clear();
        var response = await http.get(uri);
        return topRestaurants = _extractData(response);
      }
    }
    return [];
  }

  Future<List<Restaurant>?> fetchAndSetRecommendedRestaurants() async {
    recommemdedRestaurants!.clear();
    if (geolocatorProvider != null) {
      if (geolocatorProvider!.currentLocation == null) {
        await geolocatorProvider!.setCurrentLocaiton();
      }
      var params = {
        "latitude": "${geolocatorProvider!.currentLocation!.latitude}",
        "longitude": "${geolocatorProvider!.currentLocation!.longitude}",
      };
      var uri =
          Uri.https(Strings.domain, "/api/home/resturants_nearby", params);
      var response = await http.get(uri);
      var extractedData = json.decode(response.body) as List<dynamic>;
      print(extractedData.length);
      extractedData.forEach((element) {
        var restaurant = Restaurant();
        restaurant.id = element['id'];
        restaurant.name = element['name'];
        restaurant.rating = double.parse(element['rating']);
        restaurant.ownerFirstName = element['owner_First_name'];
        restaurant.ownerLastName = element['owner_Last_name'];
        restaurant.address = element['address'];
        restaurant.profileUrl = element['profile_url'];
        restaurant.latitude = double.parse(element['latitude']);
        restaurant.longitude = double.parse(element['longitude']);
        restaurant.distance = double.parse(element['distance']);
        recommemdedRestaurants!.add(restaurant);
      });
      return recommemdedRestaurants;
    }
    return [];
  }

  Future fetchAndSetTopResturant() async {
    topRestaurants!.clear();
    if (geolocatorProvider != null) {
      if (geolocatorProvider!.currentLocation == null) {
        await geolocatorProvider!.setCurrentLocaiton();
      }
      var params = {
        "latitude": "${geolocatorProvider!.currentLocation!.latitude}",
        "longitude": "${geolocatorProvider!.currentLocation!.longitude}",
      };
      var uri =
          Uri.https(Strings.domain, "/api/home/resturants_nearby", params);
      var response = await http.get(uri);
      var extractedData = json.decode(response.body) as List<dynamic>;
      print(extractedData.length);
      extractedData.forEach((element) {
        print(element);
        var restaurant = Restaurant();
        restaurant.id = element['id'];
        restaurant.name = element['name'];
        restaurant.rating = double.parse(element['rating']);
        restaurant.ownerFirstName = element['owner_First_name'];
        restaurant.ownerLastName = element['owner_Last_name'];
        restaurant.address = element['address'];
        restaurant.profileUrl = element['profile_url'];
        restaurant.latitude = double.parse(element['latitude']);
        restaurant.longitude = double.parse(element['longitude']);
        restaurant.distance = double.parse(element['distance']);
        topRestaurants!.add(restaurant);
      });
      return topRestaurants;
    }
    return [];
  }
}
