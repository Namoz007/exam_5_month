part of 'home_bloc.dart';

sealed class HomeEvent {}

final class FetchRecipesEvent extends HomeEvent {}

final class ToggleLikeEvent extends HomeEvent {
  String uId;
  String recipeId;

  ToggleLikeEvent(this.uId, this.recipeId);
}

final class GetLatestRecipesEvent extends HomeEvent {
}

final class GetTrendingRecipesEvent extends HomeEvent {
}

final class GetShortPreparedRecipesEvent extends HomeEvent {
}

/// firebasega kommentlarni qo'shish uchun event
final class AddReviewEvent extends HomeEvent {
  final String recipeId;
  final Comment review;

  AddReviewEvent(this.recipeId, this.review);
}

/// firebasedan kommentlarni olish uchun event
final class GetReviewEvent extends HomeEvent {
  final String recipedId;

  GetReviewEvent({
    required this.recipedId,
  });
}
