import 'package:flutter/material.dart';
import 'package:food_app/screens/search.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Theme.of(context).backgroundColor,
      ),
      child: TextFormField(
        onTap: () {
          Navigator.of(context).pushNamed(SearchScreen.ROUTE_NAME);
        },
        autofocus: false,
        readOnly: true,
        decoration: InputDecoration(
          fillColor: Colors.amber,
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          focusColor: Colors.grey,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(100.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        ),
      ),
    );
  }
}
