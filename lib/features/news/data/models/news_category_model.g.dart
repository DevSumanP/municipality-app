// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsCategoryModel _$NewsCategoryModelFromJson(Map<String, dynamic> json) =>
    NewsCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$NewsCategoryModelToJson(NewsCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };
