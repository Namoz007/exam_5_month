
import 'package:ExamFile/data/model/user_model.dart';
import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 3)
class Comment {
  @HiveField(0)
  int rate;
  @HiveField(1)
  String title;
  @HiveField(2)
  UserModel user;

  Comment({
    required this.rate,
    required this.title,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'title': title,
      'user': user.toJson(),
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      rate: json['rate'],
      title: json['title'],
      user: UserModel.fromJson(json['user']),
    );
  }
}