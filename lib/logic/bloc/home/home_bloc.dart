import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/recipe_controller.dart';
import '../../../data/model/comment.dart';
import '../../../data/model/recipe.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<FetchRecipesEvent>(fetchRecipes);
    on<ToggleLikeEvent>(toggleLike);
    on<GetLatestRecipesEvent>(getLatestRecipes);
    on<AddReviewEvent>(addReviewComment);
    on<GetReviewEvent>(getReviewComment);
  }
  final recipeController = RecipeController();

  Future<void> fetchRecipes(event, emit) async {
    try {
      emit(LoadingState());
      List<Recipe> recipes = await recipeController.fetchRecipes();
      emit(LoadedState(recipes));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> toggleLike(ToggleLikeEvent event, emit) async {
    recipeController.toggleLike(event.uId, event.recipeId);
  }

  Future<void> getLatestRecipes(GetLatestRecipesEvent event, emit) async {
    try {
      emit(LoadingState());
      List<Recipe>? recipes = recipeController.getLatestRecipes();
      if (recipes != null && recipes.isNotEmpty) {
        emit(LoadedState(recipes));
      } else {
        emit(ErrorState("No recipes found"));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  /// kommentlarni firebasega yuborish uchun bloc funksiya
  Future<void> addReviewComment(
      AddReviewEvent event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingState());
      await recipeController.addReviewComment(event.recipeId, event.review);
      emit(ReviewAddedState());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  /// kommentlarni firebasedan olish uchun bloc funksiya
  Future<void> getReviewComment(GetReviewEvent event, Emitter<HomeState> emit) async {

    try {
      emit(LoadingState());
      List<Comment> comments = await recipeController.getReviewComments(event.recipedId);
      print("object");
      emit(LoadedReviewState(comments: comments));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
