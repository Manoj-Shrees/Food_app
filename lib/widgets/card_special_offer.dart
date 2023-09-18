import 'package:flutter/material.dart';

class SpecialOfferCard extends StatelessWidget {
  final String image;
  final String itemName;
  final String restaurantName;
  final String category;
  final Function()? addButtonHandler;

  const SpecialOfferCard({
    required this.image,
    required this.itemName,
    required this.restaurantName,
    required this.category,
    this.addButtonHandler,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 202),
            Container(
              padding: EdgeInsets.all(15.0),
              color: Theme.of(context).backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          itemName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          restaurantName,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: addButtonHandler,
                        child: Text("ADD"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
