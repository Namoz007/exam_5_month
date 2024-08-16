import 'package:ExamFile/data/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/recipe.dart';

class MyRecipesServices {
  final _baseUrl = "https://retsept-app-db287-default-rtdb.firebaseio.com";
  String userId = AppConstants.uId;
  final _dio = Dio();

  Future<void> addSavedRecipe(String id) async {
    try {
      final response = await _dio.post(
        "$_baseUrl/users/$userId/saved.json",
        data: {
          "recipeId": id,
        },
      );
    } catch (e) {
      print("Xato: $e");
    }
  }
  
  Future<List<Recipe>> getMyRecipes() async{
    List<Recipe> _recipes = [];
    final response = await _dio.get("${_baseUrl}/recipes.json");
    Map<String,dynamic> datas =  response.data as Map<String,dynamic>;
    List<String> keys = datas.keys.toList();
    for(int i = 0;i < keys.length;i++){
      if(datas[keys[i]]['userId'] == userId) {
        _recipes.add(Recipe.fromJson(datas[keys[i]]));
      }
    }
    return _recipes;
  }

  Future<List<Recipe>> getAllMyRecipes() async{
    List<Recipe> _recipes = [];
    final response = await _dio.get("${_baseUrl}/users/${userId}.json");
    Map<String,dynamic> datas =  response.data as Map<String,dynamic>;
    List<String> keys = datas.keys.toList();
    for(int i = 0;i < keys.length;i++){
      if(datas[keys[i]]['userId'] == userId)
        _recipes.add(Recipe.fromJson(datas[keys[i]]));
    }

    return _recipes;
  }

  Future<List<Recipe>> getMySavedRecipe() async{
    List<Recipe> _mySavedRecipes = [];
    List<String> _recipesIds = [];
    final response = await _dio.get("${_baseUrl}/users/$userId/saved.json");
    Map<String,dynamic> _datas = response.data as Map<String,dynamic>;
    List<String> _keys = _datas.keys.toList();
    for(int i = 0;i < _keys.length;i++){
      _recipesIds.add(_datas[_keys[i]]['recipeId']);
    }
    for(int i = 0;i < _recipesIds.length;i++){
      final data = await _dio.get("${_baseUrl}/recipes/${_recipesIds[i]}.json");
      _mySavedRecipes.add(Recipe.fromJson(data.data as Map<String,dynamic>));
    }
    return _mySavedRecipes;
  }

  Future<void> removeMySaved(String id) async{
    try{
      await _dio.delete("${_baseUrl}/users/$userId/saved/$id.json");
    }catch(e){}
  }
}
