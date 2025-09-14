import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/news_article_entity.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel {
  final int id;
  final String title;
  final String category;
  final String date;
  @JsonKey(name: 'readTime')
  final String readTime;
  final int views;
  final String excerpt;
  @JsonKey(name: 'image')
  final String image;
  final bool featured;

  const NewsArticleModel({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.readTime,
    required this.views,
    required this.excerpt,
    required this.image,
    required this.featured,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleModelToJson(this);

  NewsArticleEntity toEntity() {
    return NewsArticleEntity(
      id: id,
      title: title,
      category: category,
      date: DateTime.parse(date),
      readTime: readTime,
      views: views,
      excerpt: excerpt,
      imageUrl: image,
      featured: featured,
    );
  }

  factory NewsArticleModel.fromEntity(NewsArticleEntity entity) {
    return NewsArticleModel(
      id: entity.id,
      title: entity.title,
      category: entity.category,
      date: entity.date.toIso8601String(),
      readTime: entity.readTime,
      views: entity.views,
      excerpt: entity.excerpt,
      image: entity.imageUrl,
      featured: entity.featured,
    );
  }
}