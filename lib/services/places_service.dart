import 'package:food_app/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  var key = "AIzaSyD0sg8PaG46PyJ0qzDu0btaBoTcqVfLtug";

  Future<List<PlaceSearch>> getAutocomplete(
    String search,
    double lat,
    double lon,
  ) async {
    var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json" +
        "?input=$search" +
        "&types=geocode" +
        "&key=$key" +
        "&location=$lat,$lon" +
        "&radius=500";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJSON(place)).toList();
  }

  Future getCoordinatesFromPlaceId(String placeId) async {
    var params = {
      "place_id": placeId,
      "key": key,
    };
    var uri =
        Uri.https("maps.googleapis.com", "/maps/api/geocode/json", params);
    var response = await http.get(uri);
  }
}
