import 'package:flutter/material.dart';
import 'package:food_app/models/place_search.dart';
import 'package:food_app/providers/geolocator_provider.dart';
import 'package:provider/provider.dart';

class AddressSearch extends SearchDelegate<PlaceSearch> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, PlaceSearch(placeId: "", description: ""));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final geolocatorProvider = Provider.of<GeolocatorProvider>(
      context,
      listen: false,
    );

    return FutureBuilder(
      future: geolocatorProvider.searchPlaces(query),
      builder: (context, AsyncSnapshot<List<PlaceSearch>> snapshot) {
        if (snapshot.hasData) {
          var places = snapshot.data;
          if (places!.length > 0) {
            return ListView.builder(
              itemBuilder: (ctx, index) => ListTile(
                title: Text(places[index].description),
                onTap: () {
                  close(context, places[index]);
                },
                tileColor: Colors.white,
              ),
              itemCount: places.length,
            );
          }
        }
        return Container();
      },
    );
  }
}
