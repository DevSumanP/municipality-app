// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticleModel _$NewsArticleModelFromJson(Map<String, dynamic> json) =>
    NewsArticleModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
      readTime: json['readTime'] as String,
      views: (json['views'] as num).toInt(),
      excerpt: json['excerpt'] as String,
      image: json['image'] as String,
      featured: json['featured'] as bool,
    );

Map<String, dynamic> _$NewsArticleModelToJson(NewsArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'date': instance.date,
      'readTime': instance.readTime,
      'views': instance.views,
      'excerpt': instance.excerpt,
      'image': instance.image,
      'featured': instance.featured,
    };
