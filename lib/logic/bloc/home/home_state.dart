part of 'home_bloc.dart';

sealed class HomeState {}

final class InitialState extends HomeState {}

final class LoadingState extends HomeState {}

final class LoadedState extends HomeState {
  List<Recipe> recipes;

  LoadedState(this.recipes);
}

final class ErrorState extends HomeState {
  String message;

  ErrorState(this.message);
}

/// kommentlar firebasega saqlanganini tekshirish uchun state
final class ReviewAddedState extends HomeState {
  final String message;

  ReviewAddedState({this.message = "Review added successfully!"});
}


/// firebasedan malumotlar kelganiga ishonch hosil qilish
final class LoadedReviewState extends HomeState {
  final List<Comment> comments;

  LoadedReviewState({required this.comments});
}

