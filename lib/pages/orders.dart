import 'package:flutter/material.dart';
import 'package:food_app/data/orders_data.dart';
import 'package:food_app/models/order.dart';
import 'package:food_app/widgets/section_title.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({Key? key}) : super(key: key);

  final List<Order> orders = OrderData.activeOrders;

  final List<Order> pastOrders = OrderData.pastOrders;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: SectionTitle("Active Orders"),
          ),
          ListView.separated(
            separatorBuilder: (_, index) => SizedBox(height: 5),
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (_, index) {
              return ListTile(
                tileColor: Colors.white,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(orders[index].image),
                ),
                title: Text(orders[index].title),
                subtitle: Text(
                  "${orders[index].price} • ${orders[index].dateTime}",
                ),
              );
            },
            itemCount: orders.length,
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: SectionTitle("Past Orders"),
          ),
          ListView.separated(
            separatorBuilder: (_, index) => SizedBox(height: 5),
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (_, index) {
              return ListTile(
                tileColor: Colors.white,
                leading: CircleAvatar(
                  backgroundImage: AssetImage(pastOrders[index].image),
                ),
                title: Text(pastOrders[index].title),
                subtitle: Text(
                  "\$${pastOrders[index].price} • ${pastOrders[index].dateTime}",
                ),
              );
            },
            itemCount: pastOrders.length,
          ),
        ],
      ),
    );
  }
}
