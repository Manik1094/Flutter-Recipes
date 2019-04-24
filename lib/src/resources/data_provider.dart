import 'package:flutter_recipes/src/models/recipe_search_response.dart';
import 'package:flutter_recipes/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DataProvider{

 Future<RecipeSearchResponse> fetchRecipesByCategory(String category , int page) async{
     final response = await http.Client()
     .get("${Constants.BASE_URL}/api/search?key=${Constants.API_KEY}&q=${category}&page=${page}");

    print(response.body.toString());
    if(response.statusCode == Constants.SUCCESS_CODE){
       return RecipeSearchResponse.fromJson(json.decode(response.body));
    } else{
      throw Exception('Failed to get recipes');
    }

 }

}