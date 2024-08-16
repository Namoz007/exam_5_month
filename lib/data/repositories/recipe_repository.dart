
import '../model/recipe.dart';
import '../services/recipes/firebase_recipe_service.dart';

class RecipeRepository {
  final FirebaseRecipeService _firebaseRecipeService = FirebaseRecipeService();

  Future<List<Recipe>?> getRecipes() {
    return _firebaseRecipeService.getRecipes();
  }
}
