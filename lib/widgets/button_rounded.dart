import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool hasLoading;

  const RoundedButton({
    required this.text,
    this.onPressed,
    this.hasLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: onPressed == null && hasLoading
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
