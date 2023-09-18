import 'package:flutter/material.dart';

class Dialogs {
  static void featureInProgress(BuildContext context) {
    _showDialog(
      context,
      "Our team and I are working night and day to make this feature available for you. Thank you for your patience.",
      "We are working on this feature.",
    );
  }

  static void loginFailed(BuildContext context, String message) {
    var _message = RegExp(r"(\w|\s|,|')+[。.?!]*\s*").allMatches(message);
    var title = _message.first;
    var content = _message.last;

    _showDialog(
      context,
      title.group(0) == null ? "Oops! Login failed!" : title.group(0)!,
      content.group(0) == null
          ? "We were unable to decode the message!"
          : content.group(0)!,
    );
  }

  static void loading(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return Material(
            child: Container(
              color: Colors.black12,
              margin: const EdgeInsets.all(10),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  static void message(BuildContext context, String message) {
    _showDialog(context, "Message", message);
  }

  static void success(BuildContext context, String message) {
    _showDialog(context, "Success", message);
  }

  static void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Okay!"),
            ),
          ],
          title: Text(title),
        );
      },
    );
  }
}
