import 'package:flutter/material.dart';
import 'package:food_app/models/user.dart';

class Images {
  static ImageProvider<Object>? buildAvatarImage(User user) {
    if (user.avatarUrl != null) {
      if (user.avatarUrl!.contains("http")) {
        return NetworkImage(user.avatarUrl!);
      }
      return AssetImage(user.avatarUrl!);
    }
    return AssetImage("assets/images/avatar_default.png");
  }
}
