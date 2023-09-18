import 'package:flutter/material.dart';

class CircularCloseButton extends StatelessWidget {
  const CircularCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).primaryColor,
      ),
      margin: EdgeInsets.only(right: 20, top: 20),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.close),
        color: Colors.white,
      ),
    );
  }
}
