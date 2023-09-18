import 'package:flutter/material.dart';
import 'package:food_app/data/categories_data.dart';
import 'package:food_app/models/category.dart';
import 'package:food_app/providers/category_provider.dart';
import 'package:food_app/widgets/section_title.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var categoriesProvider = Provider.of<CategoryProvider>(
      context,
      listen: false,
    );
    return FutureBuilder(
      future: categoriesProvider.fetchCategory(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          List<Category> categories = snapshot.data as List<Category>;
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: SectionTitle("Top Categories"),
                ),
                GridView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(categories[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(right: 5, left: 5),
                      child: Container(
                        color: Colors.black38,
                        child: Center(
                          child: Text(
                            categories[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: categories.length,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
