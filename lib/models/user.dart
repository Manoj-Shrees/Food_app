import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/util/strings.dart';
import 'package:http/http.dart' as http;

class User extends ChangeNotifier {
  String? userID;
  String? firstName;
  String? lastName;
  String? password;
  String? address;
  String? phone;
  String? email;
  String? avatarUrl;
  bool isLoggedIn;

  User({
    this.userID,
    this.firstName,
    this.lastName,
    this.password,
    this.address,
    this.phone,
    this.email,
    this.avatarUrl,
    this.isLoggedIn = false,
  });

  Future populate(String token) async {
    if (userID != null) {
      var response = await http
          .get(Uri.https(Strings.domain, "api/v1/customers/$userID"), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      Map responseData = json.decode(response.body);
      Map userData = responseData[responseData.keys.first];
      firstName = userData['First_name'];
      lastName = userData['Last_name'];
      email = userData['email'];
      avatarUrl = userData['profile_url'];
      phone = userData['ph_number'];
      isLoggedIn = true;
    }
    notifyListeners();
    return Future.value(this);
  }

  void updatePassword() {
    notifyListeners();
  }

  User creteGuestUser() {
    return User(
      firstName: "Emma",
      lastName: "Phillips",
      email: "emmaphillips@gmail.com",
      phone: "469826284",
    );
  }

  User createUserUsingEmail(String email, String password) {
    return User(
      email: email,
      password: password,
    );
  }

  User createUserUsingPhone(String phone, String password) {
    return User(
      phone: phone,
      password: password,
    );
  }

  @override
  String toString() {
    return json.encode({
      "customerId": userID,
      "fistName": firstName,
      "lastName": lastName,
      "password": password,
      "address": address,
      "phone": phone,
      "email": email,
      "avatarUrl": avatarUrl,
      "isLoggedIn": isLoggedIn,
    });
  }
}
