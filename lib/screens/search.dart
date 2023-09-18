import 'package:flutter/material.dart';
import 'package:food_app/providers/geolocator_provider.dart';
import 'package:provider/provider.dart';

class Suggestion {
  final String placeId;
  final String description;
  final String title;

  Suggestion(this.placeId, this.description, this.title);
}

class PlaceDetail {
  String? address;
  double? latitude;
  double? longitude;
  String? name;

  PlaceDetail({
    this.address,
    this.latitude,
    this.longitude,
    this.name,
  });
}

class SearchScreen extends StatelessWidget {
  static const String ROUTE_NAME = "/search";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final geolocatorProvider = Provider.of<GeolocatorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Screen"),
      ),
      body: Column(
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
            height: 200,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
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
    );
  }
}
