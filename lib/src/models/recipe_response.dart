
import 'package:flutter_recipes/src/models/recipe.dart';

class RecipeResponse{

  Recipe _recipe;

  Recipe get recipe => _recipe;

  RecipeResponse();

  RecipeResponse.fromJson(Map<String , dynamic> parsedJson){
    Recipe recipe = Recipe.fromJson(parsedJson['recipe']);
    _recipe = recipe;
  }
}