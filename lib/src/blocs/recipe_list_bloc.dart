import 'package:flutter_recipes/src/blocs/bloc_provider.dart';
import 'package:flutter_recipes/src/models/recipe.dart';
import 'package:flutter_recipes/src/models/recipe_search_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_recipes/src/resources/repository.dart';
import 'package:collection/collection.dart';

class RecipeListBloc implements BlocBase {
  // final bloc = RecipeListBloc();
  Function eq = const ListEquality().equals;

  final _repository = Repository();
  final _recipesFetcher = PublishSubject<RecipeSearchResponse>();
  RecipeSearchResponse finalRecipes = RecipeSearchResponse();

  Observable<RecipeSearchResponse> get recipesList => _recipesFetcher.stream;

  fetchRecipesByCategory(String category, int page) async {
    RecipeSearchResponse recipeSearchResponse = 
        await _repository.fetchRecipesByCategory(category, page);
        finalRecipes.recipes.clear();
    if (recipeSearchResponse.recipes.length == 0) {
      _recipesFetcher.sink.addError('No More results');
    } else {
       finalRecipes.recipes.addAll(recipeSearchResponse.recipes);
        _recipesFetcher.sink.add(finalRecipes);
       
    }
  }

  fetchNextPage(String category, int page) async {
    RecipeSearchResponse recipeSearchResponse =
        await _repository.fetchNextPage(category, page);
        
    if (recipeSearchResponse.recipes.length == 0) {
      _recipesFetcher.sink.addError('No more Results');
    } else {
      finalRecipes.recipes.addAll(recipeSearchResponse.recipes);
      _recipesFetcher.sink.add(finalRecipes);
    }
  }

 @override
  void dispose() {
    // TODO: implement dispose
    _recipesFetcher.close();
  }
}
