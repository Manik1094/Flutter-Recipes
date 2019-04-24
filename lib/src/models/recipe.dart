
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

  String get title => _title;
  String get publisher => _publisher;
  String get recipe_id => _recipe_id;
  String get image_url => _image_url;
  double get social_rank => _social_rank;
  List<String> get ingredients => _ingredients;



}