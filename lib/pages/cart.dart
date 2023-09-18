import 'package:flutter/material.dart';
import 'package:food_app/models/cart_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/widgets/section_title.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return FutureBuilder(
      future: cartProvider.fetchCartItems(),
      builder: (ctx, AsyncSnapshot<List<CartItem>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length <= 0)
            return Center(
              child: Text("Cart Empty"),
            );
          List<CartItem> cartItems = snapshot.data as List<CartItem>;

          return Consumer<CartProvider>(builder: (ctx, cartProvider, child) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Stack(children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: SectionTitle("Added Today"),
                      ),
                      ListView.separated(
                        separatorBuilder: (_, index) => SizedBox(height: 5),
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (_, index) {
                          return ListTile(
                            tileColor: Colors.white,
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(cartItems[index].image),
                            ),
                            title: Text(cartItems[index].title),
                            subtitle: Text(
                              "Quantity: ${cartItems[index].quantity} • Total: \$${cartItems[index].quantity * cartItems[index].price}",
                            ),
                          );
                        },
                        itemCount: cartItems.length,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: FloatingActionButton.extended(
                    label: Text("Order"),
                    onPressed: () {},
                    icon: Icon(Icons.inventory_outlined),
                  ),
                ),
              ]),
            );
          });
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Please Login to add items to cart."),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
