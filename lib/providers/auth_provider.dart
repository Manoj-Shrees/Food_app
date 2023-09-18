import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/util/strings.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  static const String clientSecret = "a0zexU11tnJ98IPC3tUAuRN0vAEX6KmkEHpCVipo";
  String? _token;
  User? _user;
  DateTime? _expiresAt;
  String? _refreshToken;

  bool get isLoggedIn {
    if (_token != null) return true;
    return false;
  }

  set token(String? token) {
    this.token = token;
    notifyListeners();
  }

  String? get token {
    return _token;
  }

  set user(User? user) {
    this._user = user;
    notifyListeners();
  }

  User get user {
    if (_user == null) _user = User();
    return _user!;
  }

  Future logout() {
    this._user = null;
    notifyListeners();
    return Future.value(this._user);
  }

  Future authenticate(String username, String password) async {
    var params = {
      'username': username,
      'password': password,
    };
    if (this._user == null) this._user = User();
    var response = await http.post(
      Uri.https(Strings.domain, "/api/auth/customerlogin", params),
    );

    if (response.statusCode == 401) {
      Map responseData = json.decode(response.body);
      String message = responseData['message'];
      return Future.error(
        message,
        StackTrace.fromString(message),
      );
    } else if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      if (_user == null) _user = User();
      _user!.userID = responseData.keys.first;
      _token = responseData[_user!.userID]['user_token'];
      _expiresAt = DateTime.parse(responseData[_user!.userID]['expire_at']);
      await _user!.populate(_token!);
    } else {
      return Future.error(
        "Unknown error. Contact developer!",
        StackTrace.fromString(response.toString()),
      );
    }
    notifyListeners();
    return Future.value(this._user);
  }

  Future signup({
    required String phone,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    var params = {
      "First_name": firstName,
      "Last_name": lastName,
      "email": email,
      "profile_url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUmwWU719Nj5vZPwif-fVWywEhIJTMGkADuA%26usqp=CAU",
      "password": password,
      "ph_number": phone,
    };
    if (this._user == null) this._user = User();

    var url = Uri.https(Strings.domain, "/api/auth/register", params);

    var response = await http.post(url);

    if (response.statusCode == 200) {
      var message = json.decode(response.body)['message'];
      return Future.value(message);
    } else {
      return Future.error(
        "Status: ${response.statusCode}\n Body: ${response.body}",
        StackTrace.fromString(response.toString()),
      );
    }
  }
}
