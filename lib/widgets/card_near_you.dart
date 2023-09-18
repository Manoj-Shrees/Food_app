import 'package:flutter/material.dart';

class NearYouCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final double rating;

  const NearYouCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 200),
            Container(
              height: 150,
              padding: EdgeInsets.all(15),
              color: Theme.of(context).backgroundColor,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            subtitle.replaceAll("\n", " "),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            "Categories sadflasdfljasdfklj ld fljsa dfljasd lfasld flajsd lfjs ldfjsla dfl",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.star),
                                label: Text("${rating.ceil()}"),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.favorite),
                                label: Text("Open"),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Order Now"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
