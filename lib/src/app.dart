import 'package:flutter/material.dart';
import 'package:flutter_recipes/src/ui/recipe_categories.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_recipes',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Recipes'),
        ),
      body: RecipeCategoriesScreen(),  
        
      ),
    );
  }
}