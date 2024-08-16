
import 'package:hive/hive.dart';

import 'comment.dart';
import 'ingredient.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  List<Ingredient> ingredient;

  @HiveField(2)
  String description;

  @HiveField(3)
  List<String> preparation;

  @HiveField(4)
  Duration estimatedTime;

  @HiveField(5)
  List<String> category;

  @HiveField(6)
  String imageUrl;

  @HiveField(7)
  String videoUrl;

  @HiveField(8)
  String userId;

  @HiveField(9)
  String id;

  @HiveField(10)
  bool isSaved;

  @HiveField(11)
  List<String> likes;

  @HiveField(12)
  double rate;

  @HiveField(13)
  List<Comment> comments;

  @HiveField(14)
  DateTime createdAt;

  Recipe({
    required this.title,
    required this.ingredient,
    required this.description,
    required this.preparation,
    required this.estimatedTime,
    required this.category,
    required this.imageUrl,
    required this.videoUrl,
    required this.userId,
    required this.id,
    required this.isSaved,
    required this.likes,
    required this.rate,
    required this.comments,
    required this.createdAt,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ingredient': ingredient.map((e) => e.toJson()).toList(),
      'description': description,
      'preparation': preparation,
      'estimatedTime': estimatedTime.inMilliseconds,
      'category': category,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'userId': userId,
      'id': id,
      'isSaved': isSaved,
      'likes': likes,
      'rate': rate,
      'comments': comments.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      ingredient: (json['ingredient'] as List<dynamic>?)?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      description: json['description'],
      preparation: List<String>.from(json['preparation'] ?? []),
      estimatedTime: Duration(minutes:  json['estimatedTime']),
      category: List<String>.from(json['category']),
      comments: [
        if (json['comments'] != null)
          Comment.fromJson(json['comments'] as Map<String, dynamic>)
      ],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      userId: json['userId'],
      id: json['id'],
      isSaved: json['isSaved'] ?? false,
      likes: List<String>.from(json['likes'] ?? []),
      rate: double.tryParse(json['rate'].toString()) ?? 0.0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static Duration parseDuration(String s) {
    List<String> parts = s.split(':');
    if (parts.length != 3) {
      throw const FormatException('Invalid time string format');
    }
    List<String> secondsParts = parts[2].split('.');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(secondsParts[0]);
    int microseconds = int.parse(secondsParts[1]);
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      microseconds: microseconds,
    );
  }

  factory Recipe.copy() {
    return Recipe(
      title: '',
      ingredient: [],
      description: '',
      preparation: [],
      estimatedTime: Duration(minutes: 0),
      category: [],
      comments: [],
      imageUrl: '',
      videoUrl: '',
      userId: '',
      id: '',
      isSaved: false,
      likes: ['9SjFRAq9AJSIqIshJmFA1kAHtjr1'],
      rate: 4,
      createdAt: DateTime.now(),
    );
  }
}