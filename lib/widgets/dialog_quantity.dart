import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class QuantityPickerDialog extends StatefulWidget {
  final FoodItem foodItem;

  QuantityPickerDialog({required this.foodItem, Key? key}) : super(key: key);

  @override
  _QuantityPickerDialogState createState() => _QuantityPickerDialogState();
}

class _QuantityPickerDialogState extends State<QuantityPickerDialog> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(
      context,
      listen: false,
    );
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            cartProvider.addItemToCart(widget.foodItem, value);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("$value ${widget.foodItem.name} added to cart."),
              ),
            );
            Navigator.pop(context, false);
          },
          child: Text("Ok"),
        )
      ],
      title: Text("Quantaty"),
      content: NumberPicker(
        maxValue: 10,
        minValue: 1,
        onChanged: (int) {
          setState(() {
            value = int;
          });
        },
        value: value,
      ),
    );
  }
}
