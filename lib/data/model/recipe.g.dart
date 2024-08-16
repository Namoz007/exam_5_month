// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 1;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      title: fields[0] as String,
      ingredient: (fields[1] as List).cast<Ingredient>(),
      description: fields[2] as String,
      preparation: (fields[3] as List).cast<String>(),
      estimatedTime: Duration(seconds: fields[4] as int),
      category: (fields[5] as List).cast<String>(),
      imageUrl: fields[6] as String,
      videoUrl: fields[7] as String,
      userId: fields[8] as String,
      id: fields[9] as String,
      isSaved: fields[10] as bool,
      likes: (fields[11] as List).cast<String>(),
      rate: fields[12] as double,
      comments: (fields[13] as List).cast<Comment>(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(fields[14] as int),
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.ingredient)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.preparation)
      ..writeByte(4)
      ..write(obj.estimatedTime.inSeconds)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.videoUrl)
      ..writeByte(8)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.isSaved)
      ..writeByte(11)
      ..write(obj.likes)
      ..writeByte(12)
      ..write(obj.rate)
      ..writeByte(13)
      ..write(obj.comments)
      ..writeByte(14)
      ..write(obj.createdAt.millisecondsSinceEpoch);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RecipeAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
