import 'package:flutter/material.dart';

enum SBSButtonType { outlined, elevated }

enum SBSButtonColor { accent, primary }

class SBSButtons extends StatelessWidget {
  final SBSButtonChild leftChild;
  final SBSButtonChild rightChild;
  final BuildContext context;
  final SBSButtonType type;
  final SBSButtonColor color;
  final Function()? leftHandler;
  final Function()? rightHandler;

  SBSButtons({
    required this.context,
    required this.leftChild,
    required this.rightChild,
    this.leftHandler,
    this.rightHandler,
    this.type = SBSButtonType.outlined,
    this.color = SBSButtonColor.accent,
    Key? key,
  }) : super(key: key);

  ButtonStyle leftButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18.0),
        bottomLeft: Radius.circular(18.0),
      ),
    ),
  );

  ButtonStyle rightButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18.0),
          bottomRight: Radius.circular(18.0),
        ),
      ),
    ),
  );
  Function()? getLeftHandler() {
    return leftChild.disabled ? null : leftHandler;
  }

  Function()? getRightHandler() {
    return rightChild.disabled ? null : rightHandler;
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SBSButtonType.outlined:
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: getLeftHandler(),
                  child: leftChild,
                  style: leftButtonStyle,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: getRightHandler(),
                  child: rightChild,
                  style: rightButtonStyle,
                ),
              ),
            ),
          ],
        );
      case SBSButtonType.elevated:
      default:
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: getLeftHandler(),
                  child: leftChild,
                  style: color == SBSButtonColor.accent
                      ? leftButtonStyle.merge(
                          ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : leftButtonStyle,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: getRightHandler(),
                  child: rightChild,
                  style: color == SBSButtonColor.accent
                      ? rightButtonStyle.merge(
                          ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : rightButtonStyle,
                ),
              ),
            ),
          ],
        );
    }
  }
}

class SBSButtonChild extends StatelessWidget {
  final String text;
  final Widget icon;
  final bool disabled;

  const SBSButtonChild(
    this.icon,
    this.text, {
    Key? key,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}
