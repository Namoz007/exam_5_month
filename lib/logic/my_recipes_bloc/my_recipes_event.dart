

import '../../data/model/recipe.dart';

sealed class MyRecipesEvent{}

final class GetAllMyUploadedMyRecipesEvent extends MyRecipesEvent{}

final class AddNewRecipesEvent extends MyRecipesEvent{
  Recipe recipe;

  AddNewRecipesEvent(this.recipe);
}

final class GetAllMySavedMyRecipesEvent extends MyRecipesEvent{}

final class SavedRecipeToMyMyRecipesEvent extends MyRecipesEvent {
  String id;
  bool isAdd;

  SavedRecipeToMyMyRecipesEvent(this.id,this.isAdd);
}