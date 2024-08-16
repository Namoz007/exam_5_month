
import 'package:flutter/cupertino.dart';

import '../data/model/ingredient.dart';
import '../data/model/recipe.dart';

class RecipeAddController extends ChangeNotifier {
  Recipe recipe = Recipe.copy();
  late PageController pageController;
  addNameandDicription(String name, String descriotion, int cookingtime) {
    recipe.title = name;
    recipe.description = descriotion;
    recipe.estimatedTime = Duration(minutes: cookingtime);
    notifyListeners();
  }

  addIngredientAndInstruction(
    List<Ingredient> ingredients,
    List<String> instructions,
  ) {
    recipe.ingredient = ingredients;
    recipe.preparation = instructions;
    notifyListeners();
  }

  addVideo(String filePath) {
    recipe.videoUrl = filePath;
  }

  addCotegoriys(List<String> category) {
    recipe.category = category;
    notifyListeners();
  }

  void updateRecipeImage(String path) {
    recipe.imageUrl = path;
    notifyListeners();
  }
}
