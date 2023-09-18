import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
