import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../data/model/comment.dart';
import '../data/model/recipe.dart';
import '../data/services/firebase/firebase_storage_service.dart';
import '../data/services/recipes/firebase_recipe_service.dart';
import '../data/utils/app_constants.dart';

class RecipeController {
  final firebaseRecipeService = FirebaseRecipeService();
  final Dio _dio = Dio();

  Future<bool> addRecipe(Recipe recipe) async {
    recipe.id = recipe.title;

    FirebaseStorageService firebaseStorageService = FirebaseStorageService();
    String? userId = AppConstants.uId;
    recipe.userId = userId; // Replace with FirebaseAuth instance

    if (recipe.videoUrl.isNotEmpty) {
      recipe.videoUrl = await firebaseStorageService.uploadVideo(
              File(recipe.videoUrl), recipe.title) ??
          "";
    }
    print(recipe.imageUrl);

    recipe.imageUrl = await firebaseStorageService.uploadImageToFirebase(
            File(recipe.imageUrl), recipe.title) ??
        "";

    const url =
        'https://retsept-app-db287-default-rtdb.firebaseio.com/recipes.json';

    try {
      final response = await _dio.post(
        url,
        data: json.encode(recipe.toJson()),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await _dio.get(
          'https://retsept-app-db287-default-rtdb.firebaseio.com/recipes.json');
      final data = response.data as Map<String, dynamic>;

      final List<Recipe> recipes = [];
      data.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          recipes.add(Recipe.fromJson(value));
        }
      });

      return recipes;
    } catch (e) {
      return [];
    }
  }

  Future<void> toggleLike(String uId, String recipeId) async {
    try {
      await firebaseRecipeService.toggleLike(uId, recipeId);
    } catch (e) {
      rethrow;
    }
  }

  List<Recipe>? getLatestRecipes() {
    try {
      firebaseRecipeService.getLatestRecipes();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<Recipe>?> getTrendingRecipes() async {
    try {
      await firebaseRecipeService.getTrendingRecipes();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<Recipe>?> getShortPreparedRecipes() async {
    try {
      await firebaseRecipeService.getShortPreparedRecipes();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  /// kommentlarni firebasega qo'shish
  Future<void> addReviewComment(
    String recipeId,
    Comment review,
  ) async {
    try {
      await firebaseRecipeService.addReviewComment(recipeId, review);
    } catch (e) {
      rethrow;
    }
  }

  /// kommentlarni firebasedan olish
  Future<List<Comment>> getReviewComments(String recipeId) async {
    try {
      return await firebaseRecipeService.getReviewComments(recipeId);
    } catch (e) {
      rethrow;
    }
  }
}
