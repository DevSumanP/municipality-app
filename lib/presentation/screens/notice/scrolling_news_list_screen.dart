import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewsCategory {
  final String id;
  final String name;
  final Color color;

  NewsCategory({
    required this.id,
    required this.name,
    required this.color,
  });
}

class NewsArticle {
  final int id;
  final String title;
  final String category;
  final String date;
  final String readTime;
  final int views;
  final String excerpt;
  final String image;
  final bool featured;

  NewsArticle({
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
}

class Announcement {
  final int id;
  final String title;
  final String date;
  final String priority;
  final String type;

  Announcement({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    required this.type,
  });
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String searchQuery = '';
  String selectedCategory = 'all';

  final List<NewsCategory> newsCategories = [
    NewsCategory(id: 'all', name: 'All News', color: const Color(0xFF1E40AF)),
    NewsCategory(id: 'community', name: 'Community', color: const Color(0xFF059669)),
    NewsCategory(id: 'transportation', name: 'Transportation', color: const Color(0xFFDC2626)),
    NewsCategory(id: 'environment', name: 'Environment', color: const Color(0xFF0891B2)),
    NewsCategory(id: 'public-safety', name: 'Public Safety', color: const Color(0xFFEA580C)),
    NewsCategory(id: 'events', name: 'Events', color: const Color(0xFF7C3AED)),
  ];

  final List<NewsArticle> newsArticles = [
    NewsArticle(
      id: 1,
      title: 'New Community Center Opens Downtown',
      category: 'community',
      date: '2024-01-15',
      readTime: '3 min read',
      views: 1250,
      excerpt: 'The new Springfield Community Center officially opened its doors to residents with state-of-the-art facilities including a fitness center, meeting rooms, and youth programs.',
      image: 'https://images.pexels.com/photos/3182774/pexels-photo-3182774.jpeg?auto=compress&cs=tinysrgb&w=600',
      featured: true,
    ),
    NewsArticle(
      id: 2,
      title: 'Road Construction Updates - Main Street Project',
      category: 'transportation',
      date: '2024-01-14',
      readTime: '2 min read',
      views: 890,
      excerpt: 'Main Street construction is ahead of schedule. Lane closures will continue through January with completion expected by February 15th.',
      image: 'https://images.pexels.com/photos/1109541/pexels-photo-1109541.jpeg?auto=compress&cs=tinysrgb&w=600',
      featured: false,
    ),
    NewsArticle(
      id: 3,
      title: 'Water Conservation Program Achieves 15% Reduction',
      category: 'environment',
      date: '2024-01-13',
      readTime: '4 min read',
      views: 567,
      excerpt: 'Springfield residents have successfully reduced water consumption by 15% through our community conservation program launched last year.',
      image: 'https://images.pexels.com/photos/416978/pexels-photo-416978.jpeg?auto=compress&cs=tinysrgb&w=600',
      featured: false,
    ),
    NewsArticle(
      id: 4,
      title: 'Annual Safety Fair - February 10th',
      category: 'public-safety',
      date: '2024-01-12',
      readTime: '2 min read',
      views: 423,
      excerpt: 'Join us for the Annual Public Safety Fair featuring demonstrations from fire, police, and emergency medical services.',
      image: 'https://images.pexels.com/photos/6136086/pexels-photo-6136086.jpeg?auto=compress&cs=tinysrgb&w=600',
      featured: false,
    ),
    NewsArticle(
      id: 5,
      title: 'Spring Festival Planning Committee Seeks Volunteers',
      category: 'events',
      date: '2024-01-11',
      readTime: '3 min read',
      views: 678,
      excerpt: 'Help make this year\'s Spring Festival the best yet! We need volunteers for various committees and activities.',
      image: 'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&w=600',
      featured: false,
    ),
  ];

  final List<Announcement> announcements = [
    Announcement(
      id: 1,
      title: 'City Hall Closed - Martin Luther King Jr. Day',
      date: '2024-01-15',
      priority: 'high',
      type: 'closure',
    ),
    Announcement(
      id: 2,
      title: 'Public Hearing - Zoning Amendment',
      date: '2024-01-20',
      priority: 'medium',
      type: 'meeting',
    ),
    Announcement(
      id: 3,
      title: 'Winter Weather Preparedness Tips',
      date: '2024-01-10',
      priority: 'low',
      type: 'info',
    ),
  ];

  List<NewsArticle> get filteredNews {
    return newsArticles.where((article) {
      final matchesSearch = article.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          article.excerpt.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'all' || article.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color getCategoryColor(String categoryId) {
    return newsCategories.firstWhere((cat) => cat.id == categoryId, orElse: () => NewsCategory(id: '', name: '', color: const Color(0xFF64748B))).color;
  }

  String getCategoryName(String categoryId) {
    return newsCategories.firstWhere((cat) => cat.id == categoryId, orElse: () => NewsCategory(id: categoryId, name: categoryId, color: const Color(0xFF64748B))).name;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final featuredArticle = newsArticles.where((article) => article.featured).isNotEmpty 
        ? newsArticles.firstWhere((article) => article.featured)
        : null;
    final regularArticles = newsArticles.where((article) => !article.featured).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: const Color(0xFFF8FAFC),
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'News & Updates',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stay informed about your community',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Search and Filter Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                ),
                child: Column(
                  children: [
                   

                    // Category Filters
                    SizedBox(
                      height: 36,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newsCategories.length,
                        itemBuilder: (context, index) {
                          final category = newsCategories[index];
                          final isSelected = selectedCategory == category.id;
                          
                          return Container(
                            margin: EdgeInsets.only(
                              right: index < newsCategories.length - 1 ? 12 : 20,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category.id;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? category.color : const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Announcements Section
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Important Announcements',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...announcements.take(2).map((announcement) => 
                        AnnouncementCard(announcement: announcement)
                      ),

                      // Featured Section
                      if (featuredArticle != null) ...[
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Featured',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        NewsCard(
                          article: featuredArticle,
                          featured: true,
                          screenWidth: screenWidth,
                        ),
                      ],

                      // Latest News Section
                      const SizedBox(height: 24),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Latest News',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...filteredNews.map((article) => NewsCard(
                        article: article,
                        featured: false,
                        screenWidth: screenWidth,
                      )),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> priorityColors = {
      'high': {
        'bg': const Color(0xFFFEF2F2),
        'border': const Color(0xFFFECACA),
        'text': const Color(0xFF991B1B),
      },
      'medium': {
        'bg': const Color(0xFFFFFBEB),
        'border': const Color(0xFFFED7AA),
        'text': const Color(0xFF92400E),
      },
      'low': {
        'bg': const Color(0xFFF0F9FF),
        'border': const Color(0xFFBFDBFE),
        'text': const Color(0xFF1E40AF),
      },
    };

    final colors = priorityColors[announcement.priority]!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors['bg'],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors['border']!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  announcement.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors['text'],
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: colors['text'],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            DateTime.parse(announcement.date).toString().substring(0, 10),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colors['text'],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsArticle article;
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
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              article.image,
              width: double.infinity,
              height: featured ? 200 : 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: featured ? 200 : 160,
                  color: const Color(0xFFF3F4F6),
                  child: const Icon(
                    Icons.image,
                    size: 48,
                    color: Color(0xFF64748B),
                  ),
                );
              },
            ),
          ),

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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                      DateTime.parse(article.date).toString().substring(0, 10),
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
                  style: TextStyle(
                    fontSize: featured ? 20 : 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                    height: featured ? 1.3 : 1.375,
                  ),
                ),

                const SizedBox(height: 8),

                // Excerpt
                Text(
                  article.excerpt,
                  style: TextStyle(
                    fontSize: featured ? 15 : 14,
                    color: const Color(0xFF64748B),
                    height: featured ? 1.47 : 1.43,
                  ),
                  maxLines: featured ? 3 : 2,
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