import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/section_near_you.dart';
import 'package:food_app/widgets/section_recommended_restaurants.dart';
import 'package:food_app/widgets/section_special_offer.dart';
import 'package:food_app/widgets/section_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              viewportFraction: 0.95,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/home-banner.png"),
                      ),
                    ),
                    child: Container(
                      color: Colors.black12,
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Are You Hungry?',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Order Food Now!',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Use Code ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'MARCH50',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: SectionTitle("Recommended Restaurant For You"),
          ),
          RecommendedRestaurantSection(),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: SectionTitle("Special Offer For You"),
          ),
          SpecialOfferSection(),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: SectionTitle("Top Restaurant Near You"),
          ),
          NearYouSection(),
        ],
      ),
    );
  }
}
