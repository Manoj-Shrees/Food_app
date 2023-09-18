import 'package:flutter/material.dart';
import 'package:food_app/models/place_search.dart';
import 'package:food_app/providers/geo_locator_service.dart';
import 'package:food_app/services/places_service.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorProvider with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();

  Position? currentLocation;
  List<PlaceSearch>? searchResults;

  GeolocatorProvider() {
    setCurrentLocaiton();
  }

  Future setCurrentLocaiton() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }

  Future<List<PlaceSearch>> searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(
      searchTerm,
      currentLocation!.latitude,
      currentLocation!.longitude,
    );
    notifyListeners();
    return Future.value(searchResults);
  }

  void getLatLongFromPlaceId(String placeId) {}
}
