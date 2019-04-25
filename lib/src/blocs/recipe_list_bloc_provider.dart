import 'package:flutter/material.dart';
import 'package:flutter_recipes/src/blocs/recipe_list_bloc.dart';

class RecipeListBlocProvider extends InheritedWidget {

  RecipeListBloc bloc;

  RecipeListBlocProvider({Key key , Widget child}):bloc = RecipeListBloc() ,
   super(key: key , child: child);

  @override
  bool updateShouldNotify(RecipeListBlocProvider oldWidget) {
    
    return true;
  }

  static RecipeListBloc of(BuildContext context){
        return (context.inheritFromWidgetOfExactType(RecipeListBlocProvider)
         as RecipeListBlocProvider).bloc;
  }
}
