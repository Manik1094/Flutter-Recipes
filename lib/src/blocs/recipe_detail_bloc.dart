import 'package:flutter_recipes/src/blocs/bloc_provider.dart';
import 'package:flutter_recipes/src/models/recipe_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_recipes/src/resources/repository.dart';

class RecipeDetailBloc implements BlocBase{
  final _repository = Repository();
  final _recipeFetcher = BehaviorSubject<RecipeResponse>();

  Observable<RecipeResponse> get recipe => _recipeFetcher.stream;

  fetchRecipeById(String recipeId) async {
    RecipeResponse recipeResponse = await _repository.fetchRecipeById(recipeId);
    if (recipeResponse.recipe == null) {
      _recipeFetcher.sink.addError('Failed to load recipe details');
    } else {
      _recipeFetcher.sink.add(recipeResponse);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _recipeFetcher.close();
  }
}
