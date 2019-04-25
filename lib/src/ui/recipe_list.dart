import 'package:flutter/material.dart';
import 'package:flutter_recipes/src/blocs/recipe_detail_bloc_provider.dart';
import 'package:flutter_recipes/src/blocs/recipe_list_bloc.dart';
import 'package:flutter_recipes/src/blocs/recipe_list_bloc_provider.dart';
import 'package:flutter_recipes/src/models/recipe_search_response.dart';



import 'package:flutter_recipes/src/ui/recipe_detail.dart';

class RecipeListScreen extends StatefulWidget {
  final String category;

  RecipeListScreen({this.category});
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  RecipeListBloc bloc;
  ScrollController _controller;
  int page = 1;

  @override
  void initState() {
    super.initState();

    // bloc.addInitialData();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      //ListView reached the bottom

      print('Reached bottom');
      bloc.fetchNextPage(widget.category, page + 1);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = RecipeListBlocProvider.of(context);
    print('Inside didChangeDependencies');

    bloc.fetchRecipesByCategory(widget.category, page);
  }

  @override
  Widget build(BuildContext context) {
    print('Inside build');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Recipes List'),

      // ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: bloc.recipesList,
          builder: (BuildContext context,
              AsyncSnapshot<RecipeSearchResponse> snapshot) {
            if (snapshot.hasData) {
              print('Recipes list size : ${snapshot.data.recipes.length}');
              return ListView.builder(
                controller: _controller,
                itemCount: snapshot.data.recipes.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => RecipeDetailBlocProvider(
                                    child: RecipeDetailScreen(
                                      recipe: snapshot.data.recipes[index],
                                    ),
                                  ))));
                    },
                    child: Card(
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20.0, left: 0.0, right: 0.0),
                        child: buildLayout(snapshot, index),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to load recipes',
                    style: TextStyle(color: Colors.black, fontSize: 20.0)),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildLayout(AsyncSnapshot<RecipeSearchResponse> snapshot, int index) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(snapshot.data.recipes[index].image_url))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            snapshot.data.recipes[index].title,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              snapshot.data.recipes[index].publisher,
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            Text(
              snapshot.data.recipes[index].social_rank.toStringAsFixed(2),
              style: TextStyle(color: Colors.pink, fontSize: 16.0),
            )
          ],
        )
      ],
    );
  }
}
