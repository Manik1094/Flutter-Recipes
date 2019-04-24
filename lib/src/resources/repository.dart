
import 'package:flutter_recipes/src/models/recipe_search_response.dart';
import 'package:flutter_recipes/src/resources/data_provider.dart';

class Repository {

  final _dataProvider = DataProvider();

  Future<RecipeSearchResponse> fetchRecipesByCategory(String category , int page) async{
    RecipeSearchResponse recipeSearchResponse = await _dataProvider.fetchRecipesByCategory(category , page);
    return recipeSearchResponse;
  }

Future<RecipeSearchResponse> fetchNextPage(String category , int page) async{
    RecipeSearchResponse recipeSearchResponse = await _dataProvider.fetchRecipesByCategory(category , page + 1);
    return recipeSearchResponse;
  }
}
