import 'package:flutter/material.dart';
import 'package:flutter_recipes/src/blocs/recipe_list_bloc_provider.dart';
import 'package:flutter_recipes/src/ui/recipe_list.dart';
import 'package:flutter_recipes/src/utils/constants.dart';

class RecipeCategoriesScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
  
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: Constants.DEFAULT_SEARCH_CATEGORIES.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                //TODO: Execute query based on category
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RecipeListBlocProvider(
                    
                      child: RecipeListScreen(
                    category: Constants.DEFAULT_SEARCH_CATEGORIES[index],
                  ));
                }));
              },
              child: Card(
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 0.0, right: 0.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/${Constants.DEFAULT_CATEGORIES_IMAGES[index]}.jpg'),
                      radius: 30.0,
                    ),
                    title: Text(
                      Constants.DEFAULT_SEARCH_CATEGORIES[index],
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


