import 'package:flutter_recipes/src/models/recipe.dart';

class RecipeSearchResponse {
  int _count;
  List<Recipe> _recipes = List();
 
  int get count => _count;

  List<Recipe> get recipes => _recipes;



RecipeSearchResponse(
 
);

  RecipeSearchResponse.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['recipes'].length);
    _count = parsedJson['count'];
    List<Recipe> _temp = [];
    for (var i = 0; i < parsedJson['recipes'].length; i++) {
      Recipe recipe = new Recipe(parsedJson['recipes'][i]);
      _temp.add(recipe);
     
    }
     

    _recipes = _temp;
     
  }


}
