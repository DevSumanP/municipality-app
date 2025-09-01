import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/database/app_database.dart';
import '../../providers/auth_provider.dart';
import '../../providers/database_provider.dart';

class ScrollingNewsListScreen extends ConsumerWidget {
  const ScrollingNewsListScreen({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case '1':
        return const Color(0xff2563EB);
      case '0':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final database = ref.watch(appDatabaseProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            'News',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 18),
          ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: FutureBuilder<List<DocumentsTable>>(
        future: database.documentsDao.getDocumentsByType('scrolling_news'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('No notices available')),
            );
          }
          final news = snapshot.data!.toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: news.length,
            itemBuilder: (context, index) {
              final item = news[index];
              return Card(
                color: const Color(0xffF9FAFB),
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: getStatusColor(item.status),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.status == '1' ? 'Active' : 'Inactive',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Title
                          Text(
                            user?.headerTitle ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Summary
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Footer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Iconsax.clock,
                                      size: 14, color: Color(0xFF9CA3AF)),
                                  const SizedBox(width: 4),
                                  Text(
                                    item.createdAt.toString().substring(0, 16),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Iconsax.eye,
                                      size: 14, color: Color(0xFF9CA3AF)),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '245 views',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
