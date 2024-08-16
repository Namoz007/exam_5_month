import 'package:hive/hive.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 2)
class Ingredient {
  @HiveField(0)
  String name;
  @HiveField(1)
  int quantity;
  @HiveField(2)
  String type;
  @HiveField(3)
  bool isSelected;

  Ingredient(
      {required this.name,
      required this.quantity,
      required this.type,
      required this.isSelected});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'type': type,
      'isSelected': isSelected
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      type: json['type'] ?? '',
      isSelected: json['isSelected'] ?? false,
    );
  }
}
