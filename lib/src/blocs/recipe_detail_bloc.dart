import 'package:flutter_recipes/src/models/recipe_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_recipes/src/resources/repository.dart';

class RecipeDetailBloc {
  final _repository = Repository();
  final _recipeFetcher = BehaviorSubject<RecipeResponse>();

  Observable<RecipeResponse> get recipe => _recipeFetcher.stream;

  fetchRecipeById(String recipeId) async {
    RecipeResponse recipeResponse = await _repository.fetchRecipeById(recipeId);
    if (recipeResponse == null) {
      _recipeFetcher.sink.addError('Failed to load recipe details');
    } else {
      _recipeFetcher.sink.add(recipeResponse);
    }
  }

  dispose() {
    _recipeFetcher.close();
  }
}
