import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const RestaurantCard({
    required this.image,
    required this.title,
    required this.subtitle,
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
            SizedBox(height: 152),
            Container(
              padding: EdgeInsets.all(15.0),
              color: Theme.of(context).backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          width: 230,
                          child: Text(
                            subtitle.replaceAll("\n", " "),
                            style: Theme.of(context).textTheme.headline3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
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
