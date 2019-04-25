
import 'package:flutter/material.dart';
import 'package:flutter_recipes/src/blocs/recipe_detail_bloc.dart';

class RecipeDetailBlocProvider extends InheritedWidget{
 RecipeDetailBloc bloc;

  RecipeDetailBlocProvider({Key key , Widget child}):bloc = RecipeDetailBloc() ,
   super(key: key , child: child);

  @override
  bool updateShouldNotify(RecipeDetailBlocProvider oldWidget) => true;
  static RecipeDetailBloc of(BuildContext context){
        return (context.inheritFromWidgetOfExactType(RecipeDetailBlocProvider)
         as RecipeDetailBlocProvider).bloc;
  }

}