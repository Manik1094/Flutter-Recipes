
class Recipe{

  String _title;
  String _publisher;
  String _recipe_id;
  String _image_url;
  double _social_rank;
  List<String> _ingredients;

  Recipe( recipe){
    _title = recipe['title'];
    _publisher = recipe['publisher'];
    _recipe_id = recipe['recipe_id'];
    _image_url = recipe['image_url'];
    _social_rank = recipe['social_rank'];
  
  }

  Recipe.fromJson(Map<String, dynamic> recipe){
     _title = recipe['title'];
    _publisher = recipe['publisher'];
    _recipe_id = recipe['recipe_id'];
    _image_url = recipe['image_url'];
    _social_rank = recipe['social_rank'];
    _ingredients = new List<String>();
    // recipe['ingredients'].forEach((p) => _ingredients.add());
    _ingredients =  recipe['ingredients'].cast<String>();
  }

  String get title => _title;
  String get publisher => _publisher;
  String get recipe_id => _recipe_id;
  String get image_url => _image_url;
  double get social_rank => _social_rank;
  List<String> get ingredients => _ingredients;



}

class Ingredients{

}