import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/notification";

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Screen"),
      ),
      body: Center(
        child: Text("Notification Screen"),
      ),
    );
  }
}
