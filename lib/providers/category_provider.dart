import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/util/strings.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<Category> categories;

  CategoryProvider({required this.categories});

  Future fetchCategory() async {
    categories.clear();
    var uri = Uri.https(
      Strings.domain,
      "api/home/get_item_category_list",
    );
    var response = await http.get(uri);
    if (response.statusCode == 401) {
      notifyListeners();
      return Future.error("User not Authenticated.");
    } else if (response.statusCode == 200) {
      var extractedData = json.decode(response.body) as List<dynamic>;
      extractedData.forEach(
        (element) {
          var category = Category(
            name: element['name'],
            image: element['pic_url'],
          );
          categories.add(category);
        },
      );
      notifyListeners();
      return categories;
    }
    return categories;
  }
}
