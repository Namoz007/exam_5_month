import 'package:bloc/bloc.dart';

import '../../data/model/recipe.dart';
import '../../data/repositories/recipes_repositories.dart';
import 'my_recipes_event.dart';
import 'my_recipes_state.dart';

class MyRecipesBloc extends Bloc<MyRecipesEvent, MyRecipesState> {
  final RecipesRepositories _repositories;
  List<Recipe> _recipes = [];

  MyRecipesBloc({required RecipesRepositories repo})
      : _repositories = repo,
        super(InitialMyRecipesState()) {
    on<GetAllMySavedMyRecipesEvent>(_getAllMySavedRecipes);
    on<GetAllMyUploadedMyRecipesEvent>(_getAllMyUploadedRecipes);
    on<SavedRecipeToMyMyRecipesEvent>(_savedMyRecipe);
    on<AddNewRecipesEvent>(_addNewRecipe);
  }

  void _addNewRecipe(AddNewRecipesEvent event, emit) async {
    emit(LoadingMyRecipesState());
    _recipes = await _repositories.getAllMyRecipes();
    emit(LoadedMyRecipesState(_recipes));
  }

  void _savedMyRecipe(SavedRecipeToMyMyRecipesEvent event, emit) async {
    emit(LoadingMyRecipesState());
    _repositories.addMySavedRecipe(event.id, event.isAdd);
    emit(LoadedMyRecipesState(_recipes));
  }

  void _getAllMySavedRecipes(GetAllMySavedMyRecipesEvent event, emit) async {
    emit(LoadingMyRecipesState());
    emit(LoadedMyRecipesState(await _repositories.getAllMySavedRecipes()));
  }

  void _getAllMyUploadedRecipes(
      GetAllMyUploadedMyRecipesEvent event, emit) async {
    emit(LoadingMyRecipesState());
    _recipes = await _repositories.getAllMyRecipes();
    emit(LoadedMyRecipesState(_recipes));
  }
}
