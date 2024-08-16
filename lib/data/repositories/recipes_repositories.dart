import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../model/recipe.dart';
import '../services/recipes/my_recipes_services.dart';

class RecipesRepositories {
  final MyRecipesServices _services;
  List<Recipe> _recipes = [];
  List<Recipe> _mySaved = [];
  List<String> _addSavedIds = [];
  List<String> _removeSavedIds = [];

  RecipesRepositories({required MyRecipesServices services})
      : _services = services;

  void addNewRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  Future<void> addMySavedRecipe(String id, bool add) async {
    print("mana keldi");
    if (add) {
      print('mana');
      if (_removeSavedIds.contains(id)) _removeSavedIds.remove(id);
      _addSavedIds.add(id);
    } else {
      if (_addSavedIds.contains(id)) _addSavedIds.remove(id);
      _removeSavedIds.add(id);
    }
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi) &&
        connectivityResult.contains(ConnectivityResult.mobile)) {
      for (int i = 0; i < _addSavedIds.length; i++) {
        await _services.addSavedRecipe(_addSavedIds[i]);
      }
      _addSavedIds = [];

      for (int i = 0; i < _removeSavedIds.length; i++) {
        await _services.removeMySaved(_removeSavedIds[i]);
      }
      _removeSavedIds = [];
    } else {
      Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> result) async {
        final pref = await SharedPreferences.getInstance();
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)) {
          for (int i = 0; i < _addSavedIds.length; i++) {
            await _services.addSavedRecipe(_addSavedIds[i]);
          }
          _addSavedIds = [];

          for (int i = 0; i < _removeSavedIds.length; i++) {
            await _services.removeMySaved(_removeSavedIds[i]);
          }
          _removeSavedIds = [];
        }
      });
    }
  }

  Future<List<Recipe>> getAllMyRecipes() async {
    List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      _recipes = await _services.getMyRecipes();
      hiveBox.put("myUploadedRecipes", _recipes);
    } else {
      List<dynamic> data = await hiveBox.get("myUploadedRecipes");
      _recipes = [];
      for(int i = 0;i < data.length;i++)
        _recipes.add(data[i]);
      Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)) {
          _recipes = await _services.getMyRecipes();
          hiveBox.put("myUploadedRecipes", _recipes);
        }
      });
    }
    return _recipes;
  }

  Future<List<Recipe>> getAllMySavedRecipes() async {
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      _mySaved = await _services.getMySavedRecipe();
      hiveBox.put('savedRecipes', _mySaved);
    } else {
      List data = hiveBox.get("savedRecipes");
      _mySaved = [];
      for(int i = 0;i < data.length;i++){
        _mySaved.add(data[i]);
      }
      Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)) {
          _mySaved = await _services.getMySavedRecipe();
        } else {
          final data = await hiveBox.get("mySavedRecipes") ?? [];
          return data?.cast<Recipe>() ?? [];
        }
      });
    }
    return _mySaved;
  }
}
