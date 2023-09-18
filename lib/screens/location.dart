import 'package:flutter/material.dart';
import 'package:food_app/providers/geolocator_provider.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/location_search";

  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final geolocatorProvider = Provider.of<GeolocatorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Search"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        color: Colors.white,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                geolocatorProvider.searchPlaces(value);
              },
              decoration: InputDecoration(
                fillColor: Colors.amber,
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                focusColor: Colors.grey,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      print(geolocatorProvider.searchResults![index].placeId);
                    },
                    title: Text(
                      geolocatorProvider.searchResults![index].description,
                    ),
                  );
                },
                itemCount: geolocatorProvider.searchResults != null
                    ? geolocatorProvider.searchResults!.length
                    : 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
