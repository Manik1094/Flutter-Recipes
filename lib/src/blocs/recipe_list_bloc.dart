import 'package:flutter_recipes/src/models/recipe.dart';
import 'package:flutter_recipes/src/models/recipe_search_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_recipes/src/resources/repository.dart';

class RecipeListBloc {
  // final bloc = RecipeListBloc();

  final _repository = Repository();
  final _recipesFetcher = PublishSubject<RecipeSearchResponse>();
  RecipeSearchResponse finalRecipes = RecipeSearchResponse();

  Observable<RecipeSearchResponse> get recipesList => _recipesFetcher.stream;

  fetchRecipesByCategory(String category, int page) async {
    RecipeSearchResponse recipeSearchResponse =
        await _repository.fetchRecipesByCategory(category, page);
    if (recipeSearchResponse == null) {
      _recipesFetcher.sink.addError('Failed to load recipes');
    } else {
      finalRecipes.recipes.addAll(recipeSearchResponse.recipes);
      _recipesFetcher.sink.add(finalRecipes);
    }
  }

  fetchNextPage(String category, int page) async {
    RecipeSearchResponse recipeSearchResponse =
        await _repository.fetchNextPage(category, page);
    if (recipeSearchResponse == null) {
      _recipesFetcher.sink.addError('Failed to load recipes');
    } else {
      finalRecipes.recipes.addAll(recipeSearchResponse.recipes);
      _recipesFetcher.sink.add(finalRecipes);
    }
  }

  dispose() {
    _recipesFetcher.close();
  }
}
