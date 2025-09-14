import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/features/news/presentation/widgets/announcement_card.dart';
import 'package:municipality_app/features/news/presentation/widgets/news_card.dart';
import 'package:municipality_app/shared/widgets/error_widget.dart';
import '../../../../shared/widgets/shimmer_loading.dart';
import '../providers/news_provider.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add search listener for real-time filtering
    _searchController.addListener(() {
      ref
          .read(newsNotifierProvider.notifier)
          .updateSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildShimmerCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 shimmer category buttons
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: index < 4 ? 12 : 20),
            child: const ShimmerBox(
              width: 80,
              height: 36,
              borderRadius: 20,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerAnnouncements() {
    return const Column(
      children: [
        SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ShimmerBox(width: 200, height: 20),
            ],
          ),
        ),
        SizedBox(height: 16),
        // Show 2 shimmer announcement cards
        ShimmerCard(),
        ShimmerCard(),
      ],
    );
  }

  Widget _buildShimmerFeatured() {
    return const Column(
      children: [
        SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ShimmerBox(width: 100, height: 20),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShimmerNewsCard(),
      ],
    );
  }

  Widget _buildShimmerNews() {
    return const Column(
      children: [
        SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ShimmerBox(width: 150, height: 20),
            ],
          ),
        ),
        SizedBox(height: 16),
        ShimmerNewsCard(), // Show 4 shimmer news cards
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsNotifierProvider);
    final screenWidth = MediaQuery.of(context).size.width;

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
              // Header - Always show
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(color: Colors.white),
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
                      bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
                ),
                child: Column(
                  children: [
                    // Category Filters - Show shimmer while loading
                    newsState.isLoading
                        ? _buildShimmerCategories()
                        : newsState.errorMessage.isNotEmpty
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: 36,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: newsState.categories.length,
                                  itemBuilder: (context, index) {
                                    final category =
                                        newsState.categories[index];
                                    final isSelected =
                                        newsState.selectedCategory ==
                                            category.id;

                                    return Container(
                                      margin: EdgeInsets.only(
                                          right: index <
                                                  newsState.categories.length -
                                                      1
                                              ? 12
                                              : 20),
                                      child: GestureDetector(
                                        onTap: () => ref
                                            .read(newsNotifierProvider.notifier)
                                            .updateSelectedCategory(
                                                category.id),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Color(int.parse(
                                                    '0xFF${category.color}'))
                                                : const Color(0xFFF3F4F6),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            category.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: isSelected
                                                  ? Colors.white
                                                  : const Color(0xFF64748B),
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

              // Content - Show shimmer or actual content
              Expanded(
                child: newsState.isLoading
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmerAnnouncements(),
                            _buildShimmerFeatured(),
                            _buildShimmerNews(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    : newsState.errorMessage.isNotEmpty
                        ? CustomErrorWidget(
                            errorMsg: newsState.errorMessage,
                            padding: 24,
                            onTap: () => ref
                                .read(newsNotifierProvider.notifier)
                                .refreshData(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Announcements
                                const SizedBox(height: 24),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Important Announcements',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1F2937)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...newsState.announcements.take(2).map(
                                      (announcement) => AnnouncementCard(
                                          announcement: announcement),
                                    ),

                                // Featured Article
                                if (newsState.featuredArticle != null) ...[
                                  const SizedBox(height: 24),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      'Featured',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1F2937)),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  NewsCard(
                                      article: newsState.featuredArticle!,
                                      featured: true,
                                      screenWidth: screenWidth),
                                ],

                                // Latest News
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    'Latest News (${newsState.filteredArticles.length} article${newsState.filteredArticles.length != 1 ? 's' : ''})',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1F2937)),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...newsState.filteredArticles.map((article) =>
                                    NewsCard(
                                        article: article,
                                        featured: false,
                                        screenWidth: screenWidth)),

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
