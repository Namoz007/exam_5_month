
import '../../data/model/recipe.dart';

sealed class MyRecipesState{}

final class InitialMyRecipesState extends MyRecipesState{}

final class LoadingMyRecipesState extends MyRecipesState{}

final class LoadedMyRecipesState extends MyRecipesState{
  List<Recipe> myRecipes;

  LoadedMyRecipesState(this.myRecipes);
}

final class ErrorMyRecipesState extends MyRecipesState{
  String message;

  ErrorMyRecipesState(this.message);
}
