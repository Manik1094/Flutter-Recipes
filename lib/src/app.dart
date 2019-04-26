import 'package:flutter/material.dart';
import 'package:flutter_recipes/src/blocs/bloc_provider.dart';
import 'package:flutter_recipes/src/blocs/recipe_list_bloc.dart';
import 'package:flutter_recipes/src/ui/recipe_categories.dart';
import 'package:flutter_recipes/src/ui/recipe_list.dart';
import 'package:flutter_recipes/src/utils/constants.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_recipes',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Recipes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: RecipeCategoriesScreen(),
    );
  }
}

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('Query is : $query');
    return BlocProvider(
      bloc: RecipeListBloc(),
        child: RecipeListScreen(
      category: query,
    ));
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
    ?Constants.DEFAULT_SEARCH_CATEGORIES
    :Constants.DEFAULT_SEARCH_CATEGORIES.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            //
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                    BlocProvider(
                      bloc: RecipeListBloc(),
                      child:
                     RecipeListScreen(
                          category: suggestionsList[index],
                        ))))
            );
          },
          title: Text(
            suggestionsList[index],
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        );
        // return Text(suggestionsList[index] , style: TextStyle(color: Colors.black , fontSize: 15.0),);
      },
      itemCount: suggestionsList.length,
    );
  }
}
