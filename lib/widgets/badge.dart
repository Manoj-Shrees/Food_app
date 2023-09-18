import 'package:flutter/material.dart';
import 'package:food_app/util/colours.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final int count;
  double? top;
  double? bottom;
  double? left;
  double? right;
  final int max;

  Badge({
    required this.child,
    required this.count,
    this.top,
    this.bottom,
    this.right,
    this.left,
    this.max = 10,
    Key? key,
  }) : super(key: key);

  Widget _createBadge() {
    if (count == 0)
      return SizedBox();
    else if (count >= max) {
      return _badge("${max - 1}+");
    }
    return _badge(count.toString());
  }

  Widget _createPositionedBadge() {
    if (count == 0)
      return SizedBox();
    else if (count >= max) {
      return _badgePositioned("${max - 1}+");
    }
    return _badgePositioned(count.toString());
  }

  Widget _badgePositioned(String text) {
    return Positioned(
      child: _badge(text),
      bottom: bottom,
      top: top,
      left: left,
      right: right,
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: new BoxDecoration(
        color: Colours.primary.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0.3,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      constraints: BoxConstraints(
        minWidth: 14,
        minHeight: 14,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (left == null && right == null && top == null && bottom == null) {
      return Stack(
        children: [
          child,
          _createBadge(),
        ],
      );
    } else if (left != null && right != null) {
      throw Exception("Please provide only one horizontal position.");
    } else if (top != null && bottom != null) {
      throw Exception("Please provide only one vertical position.");
    } else {
      return Stack(
        children: [child, _createPositionedBadge()],
      );
    }
  }
}
