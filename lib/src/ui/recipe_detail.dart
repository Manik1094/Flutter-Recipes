import 'package:flutter/material.dart';
import 'package:flutter_recipes/src/blocs/recipe_detail_bloc.dart';
import 'package:flutter_recipes/src/blocs/recipe_detail_bloc_provider.dart';
import 'package:flutter_recipes/src/models/recipe.dart';
import 'package:flutter_recipes/src/models/recipe_response.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailScreen({this.recipe});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  RecipeDetailBloc bloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = RecipeDetailBlocProvider.of(context);
    bloc.fetchRecipeById(widget.recipe.recipe_id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: StreamBuilder(
        stream: bloc.recipe,
        builder: (context, AsyncSnapshot<RecipeResponse> snapshot) {
          if (snapshot.hasData) {
            return Column(
              
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(snapshot.data.recipe.image_url))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    snapshot.data.recipe.title,
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0 , right: 8.0 , top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('Ingredients',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          )),

                      Text(snapshot.data.recipe.social_rank.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.pink,
                           
                            fontSize: 18.0,
                          )),    
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:8.0 , right: 8.0  ,top: 20.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.recipe.ingredients.length,
                    itemBuilder: (context , index){
                      return Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(
                          snapshot.data.recipe.ingredients[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0
                          ),
                        ),
                      );
                    },
                  ),
                )


              ],
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
