import 'package:flutter/material.dart';
import 'package:municipality_app/features/news/domain/entities/news_article_entity.dart';

class NewsCard extends StatelessWidget {
  final NewsArticleEntity article;
  final bool featured;
  final double screenWidth;

  const NewsCard({
    super.key,
    required this.article,
    required this.featured,
    required this.screenWidth,
  });

  Color getCategoryColor(String categoryId) {
    final Map<String, Color> categoryColors = {
      'community': const Color(0xFF059669),
      'transportation': const Color(0xFFDC2626),
      'environment': const Color(0xFF0891B2),
      'public-safety': const Color(0xFFEA580C),
      'events': const Color(0xFF7C3AED),
    };
    return categoryColors[categoryId] ?? const Color(0xFF64748B);
  }

  String getCategoryName(String categoryId) {
    final Map<String, String> categoryNames = {
      'community': 'Community',
      'transportation': 'Transportation',
      'environment': 'Environment',
      'public-safety': 'Public Safety',
      'events': 'Events',
    };
    return categoryNames[categoryId] ?? categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: featured ? screenWidth - 40 : null,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: getCategoryColor(article.category),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        getCategoryName(article.category),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      (article.date).toString().substring(0, 10),
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Title
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                    height: 1.375,
                  ),
                ),

                const SizedBox(height: 8),

                // Excerpt
                Text(
                  article.excerpt,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    height: 1.43,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          article.readTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.visibility,
                          size: 12,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          article.views.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.bookmark_add,
                              size: 16,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.share,
                              size: 16,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
