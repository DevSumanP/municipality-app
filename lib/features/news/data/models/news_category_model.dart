import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/news_category_entity.dart';

part 'news_category_model.g.dart';

@JsonSerializable()
class NewsCategoryModel {
  final String id;
  final String name;
  final String color;

  const NewsCategoryModel({
    required this.id,
    required this.name,
    required this.color,
  });

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$NewsCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsCategoryModelToJson(this);

  NewsCategoryEntity toEntity() {
    return NewsCategoryEntity(
      id: id,
      name: name,
      color: color,
    );
  }

  factory NewsCategoryModel.fromEntity(NewsCategoryEntity entity) {
    return NewsCategoryModel(
      id: entity.id,
      name: entity.name,
      color: entity.color,
    );
  }
}