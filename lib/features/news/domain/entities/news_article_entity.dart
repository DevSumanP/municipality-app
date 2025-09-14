class NewsArticleEntity {
  final int id;
  final String title;
  final String category;
  final DateTime date;
  final String readTime;
  final int views;
  final String excerpt;
  final String imageUrl;
  final bool featured;

  const NewsArticleEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.readTime,
    required this.views,
    required this.excerpt,
    required this.imageUrl,
    required this.featured,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsArticleEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}